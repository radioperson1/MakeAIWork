#!/usr/bin/env python

from django.urls import path
from .views import NetlifyListApiView

urlpatterns = [
    path('api/netlify', NetlifyListApiView.as_view())
]