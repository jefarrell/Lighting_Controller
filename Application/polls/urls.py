from django.conf.urls import url
from . import views

urlpatterns = [
	# Main URL, lists all choices
	url(r'^$', views.IndexView.as_view(), name='index'),
	# URL choice a detailed view of a choice
	url(r'^(?P<pk>[0-9]+)/$', views.DetailView.as_view(), name='detail'),
	
	#polls/5/results
	#url(r'^(?P<pk>[0-9]+)/results/$',views.ResultsView.as_view(), name='results'),

	# A URL to hit to send the values
	url(r'^(?P<question_id>[0-9]+)/sendVals/$', views.sendVals, name='sendVals'),
	url(r'^(?P<question_id>[0-9]+)/dbTest/$', views.dbTest, name='dbTest'),
]