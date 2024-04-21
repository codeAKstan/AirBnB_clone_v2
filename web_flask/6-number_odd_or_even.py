#!/usr/bin/python3
"""
This script starts a Flask web application.
"""

from flask import Flask, render_template

app = Flask(__name__)


@app.route('/', strict_slashes=False)
def hello():
    """
    Route to display "Hello HBNB!"
    """
    return "Hello HBNB!"


@app.route('/hbnb', strict_slashes=False)
def hbnb():
    """
    Route to display "HBNB"
    """
    return "HBNB"


@app.route('/c/<text>', strict_slashes=False)
def c(text):
    """
    Route to display "C ", followed by the value of the text variable.
    Replace underscore _ symbols with a space.
    """
    return "C " + text.replace("_", " ")


@app.route('/python/', defaults={'text': 'is cool'}, strict_slashes=False)
@app.route('/python/<text>', strict_slashes=False)
def python(text):
    """
    Route to display "Python ", followed by the value of the text variable.
    Replace underscore _ symbols with a space.
    Default value of text is "is cool".
    """
    return "Python " + text.replace("_", " ")


@app.route('/number/<int:n>', strict_slashes=False)
def number(n):
    """
    Route to display "<n> is a number" only if n is an integer.
    """
    return "{} is a number".format(n)


@app.route('/number_template/<int:n>', strict_slashes=False)
def number_template(n):
    """
    Route to display a HTML page only if n is an integer.
    """
    return render_template('6-number_template.html', number=n)


@app.route('/number_odd_or_even/<int:n>', strict_slashes=False)
def number_odd_or_even(n):
    """
    Route to display a HTML page only if n is an integer.
    """
    if n % 2 == 0:
        even_odd = "even"
    else:
        even_odd = "odd"
    return render_template('6-number_odd_or_even.html',
                           number=n, even_odd=even_odd)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
