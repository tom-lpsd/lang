from djbookshelf.shelf.models import Book
from django.contrib import admin

class BookAdmin(admin.ModelAdmin):
    list_display = ('title', 'author')

admin.site.register(Book, BookAdmin)
