# Les bases de Dart pour Flutter

Inspiré du [guide rapide officiel](https://dart.dev/guides/language/language-tour).

## Variables

Les variables sont typées, le mot clé `var` 'devine' le type automatiquement. C'est généralement ce que l'on utilise.

```dart
var foo = 'bar';
foo = 5; // ne compile pas
```

On peut aussi préciser le type manuellement.

```dart
String foo = 'bar';
```

Le mot clé `dynamic` permet de stocker n'importe quelle variable, sans se soucier de son type. On peut aussi appeler les méthodes que l'on veut dessus sans générer de warnings.

```dart
dynamic foo = 5;
foo = 'bar';
print(foo.length); // affiche 3
```

C'est quasiment l'équivalent du type `Object` (à l'exception près des warnings). Même exemple, avec `Object` :

```dart
Object foo = 5;
foo = 'bar';
print(foo.length); // ne compile pas
```

Le mot clé `final` permet de bloquer l'assignement à une variable.

```dart
final foo = 'bar';
foo = 'baz'; // ne compile pas
```

Attention : les objets peuvent toujours être mutable (une liste peut toujours être modifiée par exemple).

Le mot clé `const` permet de rendre un objet immutable, son état est calculé à la compilation.

```dart
const foo = ['bar'];
foo.add('baz'); // ne compile pas
```

Note : le mot clé const est récursif, si on l'utilise sur une liste, tout les éléments de la liste deviennent `const`.

Enfin, toutes les variables sont initiaisées à null par défaut, ce qui peut être contre-intuitif.

```dart
double foo;
print(foo); // null

bool bar;
print(bar); // null
```

## Quelques types utiles

```dart
int foo = 0;
double foo = 0;
num foo = 0; // parent de int et double

String foo = 'bar';

bool foo = false;

List foo = [1, 2, 3];
Set foo = {'first', 'second', 'third'};
Map foo = {'a': 1, 'b': 2};
```

## Afficher du texte

On peut utiliser la fonction `print` (aussi utilisable avec Flutter) :

```dart
print('hello world');
```

L'interpolation de chaine se fait avec le symbole `$` :

```dart
var a = 5;
print('a = $a'); // a = 5
print('a plus 1 = ${a + 1}'); // a plus 1 = 6
```

## Conditions

Même syntaxe que JS / Java :

```dart
int val = 10;

if (val < 10) {
  print('< 10');
} else if (val == 10) {
  print('== 10');
} else {
  print('> 10');
}
```

## Boucles

Même syntaxe que JS / Java :

```dart
for (var i = 0; i < 10; i++) {
  print(i);
}

var foo = ['bar', 'baz'];

for (var el in foo) {
  print(el);
}
```

## Fonctions

Tout programme dart doit définir une fonction main (y compris avec Flutter):

```dart
void main() {}
```

La syntaxe est familière :

```dart
ReturnType methodName(args) {
  body
}

void greet(String name) {
  print('hello $name');
}
```

Si la fonction ne fait qu'une ligne, on peut écrire :

```dart
ReturnType methodName(args) => body;
void greet(String name) => print('hello $name');
```

### Arguments nommés

On peut définir des arguments nommés

```dart
void foo({bool a, int b}) {
  print(a);
  print(b);
}

foo(b: 1, a: false);
```

Attention : les arguments ne sont pas requis. Si ils ne sont pas passés, ils seront `null`.

On peut annoter des arguments comme `required`, ce qui bloque la compilation si l'argument n'est pas passé :

```dart
import 'package:meta/meta.dart';
void foo({bool a, @required int b}) {}
foo(a: true); // ne compile pas
```

... mais il faut installer le package [meta](https://pub.dev/packages/meta). Une section sur les packages est plus bas.

### Fonctions d'ordre supérieur et anonymes

On peut passer des fonctions à d'autres fonctions (fonctions d'ordre supérieur) :

```dart
var list = [1, 2, 3];
list.forEach(print); // affiche 1 2 3 sur trois lignes
```

On peut aussi définir des fonctions anonymes, elles sont très utilisées avec flutter.

```dart
var list = [1, 2, 3];
list.forEach((el) {
  print('el = $el');
});
```

Où alors sur une seule ligne :

```dart
var list = [1, 2, 3];
list.forEach(el => print('el = $el'));
```

## Égalité

Avec dart, l'opérateur `==` vérifie l'égalité par valeur, pas que les deux objets sont les mêmes.

```dart
var a = 'foo';
var b = 'foo';
print(a == b); // true
```

Si on veut vérifier que deux objets sont les mêmes, on peut utiliser la fonction `identical` :

```dart
var a = 'foo';
var b = 'foo';
print(identical(a, a)); // true
print(identical(a, b)); // false
```

## Méthodes pour gérer les variables nulles

On peut utiliser l'opérateur `??=` pour assigner une valeur à une variable si elle est nulle.

```dart
var foo;
foo ??= 'bar'; // assigne
foo ??= 'baz'; // n'assigne pas (car foo n'est pas null)
print(foo); // bar
```

On peut également utiliser l'opérateur `??` dans n'importe quelle expression :

```dart
var foo;
print(foo ?? 'bar'); // bar
```

Enfin, on a l'opérateur `?.` pour appeler une méthode si la variable n'est pas nulle (et renvoyer null sinon).

```dart
dynamic foo;
foo?.doSomething(); // ne fait rien, car foo est null
```

## Les classes

On peut définir une classe :

```dart
class Point {
  double x, y;
  Point(this.x, this.y);
}
```

La syntaxe `Point(this.x, this.y)` est équivalente à :

```dart
  Point(double x, double y) {
    this.x = x;
    this.y = y;
  }
```

Quand on instantie un objet, le mot clé `new` est optionnel:

```dart
var point = new Point();
var point = Point();
```

### Constructeurs nommés

```dart
class Point {
  double x, y;
  Point.foo(double x) {
    this.x = x;
    this.y = x;
  }
}

var point = Point.foo(5);
print(point.x); // 5
print(point.y); // 5
```

### Modificateurs d'accès

Contrairement au Java, il n'existe pas de mot clé `private`, `protected` ou `public`. On utilise simplement un `_` pour indiquer qu'un champs / qu'une méthode est privé(e) :

```dart
class Foo {
  String _bar;
  Foo(this._bar);
}

var foo = Foo('baz');
print(foo._bar); // affiche baz, mais on sait que l'on ne devrait pas faire ça
```

De plus, les champs / méthodes commençant par `_` ne sont pas accessible depuis une autre librairie (plus sur ça plus bas).

### Champs finaux

On peut s'attendre à pouvoir écrire :

```dart
class Foo {
  final String bar;

  Foo(String bar) {
    this.bar = bar;
  }
}
```

... mais ce code ne compile pas. On **doit** utiliser la syntaxe `Foo(this.bar)`.

Si on a besoin de modifier les variables, on aura besoin d'une syntaxe spéciale :

```dart
class Foo {
  final String bar;
  final String baz;

  Foo(String bar, String baz)
      : this.bar = 'bar: $bar',
        this.baz = 'baz: $baz';
}
```

### Héritage

```dart
class Foo {
  void foo() {
    print('foo');
  }
}

class Bar extends Foo {}

var bar = Bar();
bar.foo(); // foo
```

Si on doit appeler `super`, on a besoin de la même syntaxe spéciale :

```dart
class Foo {
  String value;
  Foo(this.value);
}

class Bar extends Foo {
  final String baz;

  Bar(String baz, String value)
      : this.baz = 'baz: $baz',
        super(value);
}
```

Attention : l'appel à `super` doit toujours être la dernière dans la liste.

### Const

On peut permettre la création d'objets constants :

```dart
class Foo {
  final String value;
  const Foo(this.value);
}

const foo = Foo();
```

On doit aller obligatoirement marquer tout les champs avec le mot clé `final`.

### Getters & Setters

On peut définir des getters et des setters :

```
class Foo {
  int x;
  Foo(this.x);

  int get xPlusOne {
    return x + 1;
  }

  // On aurait pu écrire:
  // int get xPlusOne => x + 1;

  set xPlusOne(int value) {
    x = value - 1;
  }
}

var foo = Foo(0);
print(foo.xPlusOne);
foo.xPlusOne = 2;
print(foo.x);
```

## Const

Le mot clé `const` permet, comme dit au-dessus, d'immobiliser l'état entier d'une variable. Il n'a pas été précisé qu'on peut l'utiliser dans une expression :

```dart
class Foo {
  Object bar;
  Foo(this.bar);
}

var foo = Foo(const Object());
```

Ainsi, l'instance `foo` n'est pas `const`, mais l'objet qu'elle stocke l'est.

On peut utiliser le mot clé `const` en créant des collections :

```dart
var foo = const ['bar', 'baz];
var foo = const {'bar', 'baz'};
var foo = const {'a': 1, 'b': 2};
```

## TODO

classes abstraites
types génériques
packages
enum

