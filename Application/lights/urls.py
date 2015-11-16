from django.conf.urls import url
from . import views

urlpatterns = [
	# Main URL, lists all choices
	url(r'^$', views.IndexView.as_view(), name='index'),

	# URL for setup
	url(r'^setup/$', views.stepThrough, name='setup'),
	
	# A URL to hit to send the values
	url(r'^(?P<question_id>[0-9]+)/sendVals/$', views.sendVals, name='sendVals'),
	url(r'^(?P<question_id>[0-9]+)/dbTest/$', views.dbTest, name='dbTest'),
]