from django.conf.urls.defaults import *

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

from djbookshelf.shelf.models import Book

urlpatterns = patterns('',
    # Example:
    # (r'^djbookshelf/', include('djbookshelf.foo.urls')),

    # Uncomment the admin/doc line below and add 'django.contrib.admindocs' 
    # to INSTALLED_APPS to enable admin documentation:
    # (r'^admin/doc/', include('django.contrib.admindocs.urls')),

    (r'^djbookshelf/$', 'django.views.generic.list_detail.object_list',
     {'queryset': Book.objects.all(), 'paginate_by': 2}),

    # Uncomment the next line to enable the admin:
    (r'^admin/(.*)', admin.site.root),
)
