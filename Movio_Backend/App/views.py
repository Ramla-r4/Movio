
from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
import requests
from sklearn.metrics.pairwise import cosine_similarity
from transformers import BertTokenizer, BertModel
import torch
import numpy as np

# Load the tokenizer and BERT model globally to avoid reloading
tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')
model = BertModel.from_pretrained('bert-base-uncased')

def get_embedding(text):
    """
    Generate embeddings for a given text using BERT.
    """
    inputs = tokenizer(text, return_tensors="pt", truncation=True, padding=True, max_length=512)
    with torch.no_grad():
        outputs = model(**inputs)
    # Use the mean of the last hidden state as the embedding
    return outputs.last_hidden_state.mean(dim=1).numpy()

class FetchMovieAPIView(APIView):
    def post(self, request):
        description = request.data.get('description', '').lower().strip()  # User's search input
        if not description:
            return Response({"error": "Description is required."}, status=400)

        API_KEY = "c40a87d721b4190de1e4094ee817d254"

        # Fetch all genres from TMDb API
        genre_url = f"https://api.themoviedb.org/3/genre/movie/list?api_key={API_KEY}"
        genre_response = requests.get(genre_url).json()
        genre_dict = {genre['name'].lower(): genre['id'] for genre in genre_response.get('genres', [])}

        # Check if the keyword matches a genre
        genre_id = genre_dict.get(description)

        if genre_id:
            # Search by genre ID if available
            url = f"https://api.themoviedb.org/3/discover/movie?api_key={API_KEY}&with_genres={genre_id}"
        else:
            # Otherwise, search all movies based on the keyword
            url = f"https://api.themoviedb.org/3/search/movie?api_key={API_KEY}&query={description}"

        response = requests.get(url).json()

        # Prepare the embedding for the user's input description
        user_input_embedding = get_embedding(description)

        # Collect movies and calculate similarity
        movies = []
        similarities = []
        for result in response.get('results', []):
            movie_title = result.get('title', 'No Title')
            movie_description = result.get('overview', '').lower()

            if movie_description:
                movie_embedding = get_embedding(movie_description)  # Generate embedding for movie overview
                similarity = cosine_similarity(user_input_embedding, movie_embedding)[0][0]  # Compute similarity

                movies.append({
                    'title': movie_title,
                    'description': result.get('overview', ''),
                    'release_date': result.get('release_date', None),
                    'rating': result.get('vote_average', None),
                    'poster_url': f"https://image.tmdb.org/t/p/w500{result['poster_path']}" if result.get('poster_path') else None,
                })
                similarities.append(similarity)

        # Sort movies by similarity in descending order
        if similarities:
            movies = [movie for _, movie in sorted(zip(similarities, movies), key=lambda x: x[0], reverse=True)]

        return Response(movies)
