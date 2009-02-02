from django.db import models

class Book(models.Model):
    isbn = models.CharField(blank=True, max_length=100)
    author = models.CharField(blank=False, max_length=100)
    title = models.CharField(blank=False, max_length=100)
    price = models.DecimalField(max_digits=8, decimal_places=2)

    def __unicode__(self):
        return self.title
