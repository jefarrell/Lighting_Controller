from django import forms

class PostForm(forms.Form):
	question_T = forms.CharField(max_length=256)
	created_at = forms.DateTimeField()