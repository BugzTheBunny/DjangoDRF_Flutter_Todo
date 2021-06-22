from django.db import models

# Create your models here.


class Todo(models.Model):
    title = models.CharField(max_length=255)
    description = models.TextField()
    status = models.BooleanField(default=False)

    def __str__(self) -> str:
        return f'{self.title} : {self.description} , Done:{self.status}'
