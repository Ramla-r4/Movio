from django.db import models
from django.contrib.auth.models import User
from django.db import models
from django.db import models
from django.db import models


#Movie Model
class Movie(models.Model):
    title = models.CharField(max_length=255)
    description = models.TextField()
    release_date = models.DateField(null=True, blank=True)
    rating = models.FloatField(null=True, blank=True)
    poster_url = models.URLField(null=True, blank=True)
    genre = models.CharField(max_length=255, null=True, blank=True)

    def __str__(self):
        return self.title
    

#UserPreference Model
class UserPreference(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    favorite_genres = models.TextField(null=True, blank=True)  # Comma-separated genres
    min_rating = models.FloatField(default=0)

    def __str__(self):
        return f"Preferences of {self.user.username}"
    

#Recommendation Model
class Recommendation(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    base_movie = models.CharField(max_length=255)
    recommended_movies = models.ManyToManyField(Movie)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Recommendations for {self.user.username if self.user else 'Anonymous'}"
