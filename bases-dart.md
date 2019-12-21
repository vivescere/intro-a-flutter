# Les bases de Dart pour Flutter

Fortement inspiré du [guide rapide officiel](https://dart.dev/guides/language/language-tour), mais ré-organisé pour pouvoir commencer à programmer en flutter rapidement.

Ce document ne présente que de la syntaxe, et très peu de fonctions et librairies utiles (que l'on peut trouver rapidement en cherchant sur le web).

**Attention : ce guide est fait pour ceux qui ont déjà programmé dans des langages orientés objet. Il est fait pour apprendre une nouvelle syntaxe, pas (ou très peu) des nouveaux concepts.**

Vous pouvez essayer du code dart sur [dartpad.dev](https://dartpad.dev).

- [L'essentiel](#lessentiel)
  + [Variables](#variables)
  + [Quelques types utiles](#quelques-types-utiles)
  + [Afficher du texte](#afficher-du-texte)
  + [Conditions](#conditions)
  + [Boucles](#boucles)
  + [Fonctions](#fonctions)
    - [Arguments nommés](#arguments-nommés)
    - [Fonctions d'ordre supérieur et anonymes](#fonctions-dordre-supérieur-et-anonymes)
  + [Égalité](#égalité)
  + [Les classes](#les-classes)
    - [Constructeurs nommés](#constructeurs-nommés)
    - [Modificateurs d'accès](#modificateurs-daccès)
    - [Champs finaux](#champs-finaux)
    - [Héritage](#héritage)
    - [Const](#const)
  + [Const](#const-1)
  + [Les librairies](#les-librairies)
- [Pour aller plus loin](#pour-aller-plus-loin)
  + [Variables et Méthodes statiques](#variables-et-méthodes-statiques)
  + [Méthodes pour gérer les variables nulles](#méthodes-pour-gérer-les-variables-nulles)
  + [Fonctions : Getters & Setters](#fonctions--getters--setters)
  + [Les énumérations](#les-énumérations)
  + [Les mixins](#les-mixins)
  + [Les constructeurs factory](#les-constructeurs-factory)
  + [Les classes abstraites & Interfaces](#les-classes-abstraites--interfaces)
  + [Les types génériques](#les-types-génériques)
  + [Les packages](#les-packages)

## L'essentiel

### Variables

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

Attention : les objets peuvent toujours être mutables (une liste peut toujours être modifiée par exemple).

Le mot clé `const` permet de rendre un objet immutable, son état est calculé à la compilation.

```dart
const foo = ['bar'];
foo.add('baz'); // ne compile pas
```

Note : le mot clé const est récursif, si on l'utilise sur une liste, tous les éléments de la liste deviennent `const`.

Enfin, toutes les variables sont initialisées à null par défaut, ce qui peut être contre-intuitif.

```dart
double foo;
print(foo); // null

bool bar;
print(bar); // null
```

### Quelques types utiles

```dart
int foo = 0;
double foo = 0;
num foo = 0; // parent de int et double

String foo = 'bar';

bool foo = false;

List foo = [1, 2, 3];
Set foo = {'first', 'second', 'third'};
Map foo = {'a': 1, 'b': 2};

// Syntaxe équivalentes pour la liste :
List foo = <int>[1, 2, 3];

// Syntaxe équivalente pour le set :
Set foo = <String>{'first', 'second', 'third'};

// Syntaxe équivalentes pour la map :
Map foo = <String, int>{'a': 1, 'b': 2};
```

Fonctions (basiques) sur les collections :

 - les listes ([documentation](https://api.dartlang.org/stable/2.7.0/dart-core/List-class.html))
    ```dart
    var l = [1, 2, 3];
    print(l[0]);
    l[0] = 5;
    print(l.length);
    l.add(5);
    l.removeAt(0);
    ```
 - les set ([documentation](https://api.dartlang.org/stable/2.7.0/dart-core/Set-class.html))
    ```dart
    var s = {'hello', 'world'};
    print(s.length);
    print(s.contains('hello'));
    s.add('hello');
    s.remove('world');
    ```
  - les map ([documentation](https://api.dartlang.org/stable/2.7.0/dart-core/Map-class.html))
    ```dart
    var m = {'a': 1, 'b': 2};
    print(m.length);
    print(m['a']);
    m['c'] = 5;
    m.remove('c');
    ```

### Afficher du texte

On peut utiliser la fonction `print` (aussi utilisable avec Flutter) :

```dart
print('hello world');
```

L'interpolation de chaîne se fait avec le symbole `$` :

```dart
var a = 5;
print('a = $a'); // a = 5
print('a plus 1 = ${a + 1}'); // a plus 1 = 6
```

### Conditions

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

### Boucles

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

### Fonctions

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

#### Arguments nommés

On peut définir des arguments nommés :

```dart
void foo({bool a, int b}) {
  print(a);
  print(b);
}

foo(b: 1, a: true); // affiche true puis 1
```

Attention : les arguments nommés ne sont pas requis. S'ils ne sont pas passés, ils seront `null`.

On peut annoter des arguments comme `required`, ce qui bloque la compilation si l'argument n'est pas passé :

```dart
import 'package:meta/meta.dart';
void foo({bool a, @required int b}) {}
foo(a: true); // ne compile pas
```

... mais il faut installer le package [meta](https://pub.dev/packages/meta). Une section sur les packages est plus bas.

On peut aussi donner des valeurs par défaut aux arguments :

```dart
void foo({bool a = false, int b = 0}) {
  print(a);
  print(b);
}

foo(); // affiche false puis 0
```

#### Fonctions d'ordre supérieur et anonymes

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

Ou alors sur une seule ligne :

```dart
var list = [1, 2, 3];
list.forEach(el => print('el = $el'));
```

### Égalité

Avec dart, l'opérateur `==` vérifie l'égalité par valeur, il ne vérifie pas que les deux objets sont les mêmes.

```dart
var a = 'foo';
var b = 'foo';
print(a == b); // true
```

Si on veut vérifier que deux objets sont les mêmes, on peut utiliser la fonction `identical` :

```dart
var a = Object();
var b = Object();
print(identical(a, a)); // true
print(identical(a, b)); // false
```

### Les classes

On peut définir une classe :

```dart
/// Ceci est un docstring (commentaire qui décrit la classe / fonction)
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

Quand on instancie un objet, le mot clé `new` est optionnel:

```dart
var point = new Point();
var point = Point();
```

#### Constructeurs nommés

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

#### Modificateurs d'accès

Contrairement au Java, il n'existe pas de mot clé `private`, `protected` ou `public`. On utilise simplement un `_` pour indiquer qu'un champ / qu'une méthode est privé(e) :

```dart
class Foo {
  String _bar;
  Foo(this._bar);
}

var foo = Foo('baz');
print(foo._bar); // affiche baz, mais on sait que l'on ne devrait pas faire ça
```

De plus, les champs / méthodes commençant par `_` ne sont pas accessibles depuis une autre librairie (plus sur les librairies plus bas).

#### Champs finaux

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

#### Héritage

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

#### Const

On peut permettre la création d'objets constants :

```dart
class Foo {
  final String value;
  const Foo(this.value);
}

const foo = Foo();
```

On doit aller obligatoirement marquer tous les champs avec le mot clé `final`.

### Const

Le mot clé `const` permet, comme dit ci-dessus, d'immobiliser l'état entier d'une variable. Il n'a pas été précisé qu'on peut l'utiliser dans une expression :

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
var foo = const ['bar', 'baz'];
var foo = const {'bar', 'baz'};
var foo = const {'a': 1, 'b': 2};
```

### Les librairies

On peut scinder son code en plusieurs fichiers. Il faut ensuite importer ce dont on a besoin, par exemple :

```dart
// a.dart
import 'b.dart';

void main() {
  b(); // b called
}
````

```dart
// b.dart
void b() => print('b called');
```

On a quelques variations sur la syntaxe :

```dart
// On importe seulement foo depuis file
import 'file.dart' show foo;

// On importe tout sauf foo depuis file
import 'file.dart' hide foo;

// On importe en utilisant un préfixe.
import 'file.dart' as foo;
foo.method(); // par exemple
```

On se sert aussi de ce système d'import pour charger des packages, c'est-à-dire des librairies externes. Par exemple :

```dart
// Importe le fichier material.dart depuis le package flutter
import 'package:flutter/material.dart';
```

... mais aussi des outils natifs à dart. Par exemple, si on veut charger la librairie (native) qui gère le HTML, on fait :

```dart
import 'dart:html';
```

Plus de détails sur les packages sont disponibles ci-dessous.

## Pour aller plus loin

### Variables et Méthodes statiques

On peut définir des variables et des méthodes statiques.

```dart
class Sample {
  static var count = 0;

  static int incr() {
    return count++;
  }
}

print(Sample.incr()); // 0
print(Sample.incr()); // 1
```

### Méthodes pour gérer les variables nulles

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

### Fonctions : Getters & Setters

On peut définir des getters et des setters :

```dart
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

### Les énumérations

On peut définir des énumérations :

```dart
enum Color { red, green, blue }
```

On peut ensuite les utiliser dans plein de contextes, comme par exemple dans les switch :

```dart
var col = Color.red;

switch (col) {
  case Color.red:
    ...;
    break;

  case Color.green:
    ...;
    break;
  
  case Color.blue:
    ...:
    break;

  default:
    break;
}
```

### Les mixins

Les mixins sont peut être un nouveau concept pour vous, ils servent à réutiliser du code entre plusieurs classes sans utiliser l'héritage.

```dart
mixin MyMixin {
  bool aField = false;

  void aMethod() => print('called aMethod');
}

class MyClass with MyMixin {
  void foo() => print('foo');
}

var c = MyClass();
c.foo(); // foo

print(c.aField); // false
c.aMethod(); // called aMethod
```

On peut aussi spécifier qu'une mixin ne s'applique que sur un certain type :

```dart
mixin MyMixin on MyType {
  ...
```

### Les constructeurs factory

C'est une syntaxe spéciale autour du pattern factory.

```dart
class Point {
  double x, y;

  // constructeur normal
  Point(this.x, this.y);

  // constructeur nommé
  Point.withSameCoordinateWithoutFactory(double v) {
    this.x = v;
    this.y = v;
  }

  // factory
  factory Point.withSameCoordinate(double v) {
    return Point(v, v);
  }
}
```

### Les classes abstraites & Interfaces

On peut définir une classe abstraite :

```dart
abstract class Foo {
  void foo();
}

class Bar extends Foo {
  @override
  void foo() {
    print("foo");
  }
}
```

Contrairement au Java par exemple, on n'a pas de moyen de définir une interface. A la place, on utilise les interfaces implicites. Dès que l'on définit une classe, l'ensemble des méthodes qui la composent forment une interface.

Par exemple :

```dart
class Greeter {
  void greet(String name) => print('Hello $name');
}

/*
On a créé l'équivalent (en Java) de:

interface Greeter {
  void greet(String name);
}
*/

class FooGreeter implements Greeter {
  @override
  void greet(String name) => print('Foo $name');
}
```

Attention : les variables que l'on définit font partie de l'interface. Il faut que la classe les définisse aussi (ou alors un getter et un setter).

On peut utiliser les classes abstraites pour avoir quelque chose de plus proche d'une interface en Java :

```dart
abstract class Greeter {
  void greet(String name);
}

class FooGreeter implements Greeter {
  @override
  void greet(String name) => print('Foo $name');
}
```

### Les types génériques

On peut définir des classes / fonctions génériques, avec une syntaxe très familière :

```dart
class MyList<T> {
  var _list = <T>[];

  T get(int pos) => _list[pos];
  void add(T element) => _list.add(element);
}

var l = MyList<String>();
l.add('hello');
l.add('world');
print(l.get(0)); // 'hello'
print(l.get(1)); // 'world'
```

On en a utilisé plus haut avec les collections :

```dart
List<int> foo = <int>[1, 2, 3];
Set<String> foo = <String>{'first', 'second', 'third'};
Map<String, int> foo = <String, int>{'a': 1, 'b': 2};
```

Seulement les bases des types génériques sont présentées ici, je vous invite à aller voir le [guide officiel](https://dart.dev/guides/language/language-tour#generics).

### Les packages

Dart a un gestionnaire de package intégré, appelé [pub](https://pub.dev/). Dans chaque projet dart, on retrouve un fichier `pubspec.yaml`, c'est celui-ci que l'on va éditer pour récupérer un package depuis pub.

Note : il n'est pas nécessaire d'être très familier avec YAML, seulement d'avoir des bases.

Il suffit d'ajouter une clé à l'objet `dependencies`. Par exemple, si on voulait installer le package `meta`, on aurait :

```yaml
...

dependencies:
  meta: ^1.1.8

...
```

Il suffit ensuite de lancer `pub get` ou `flutter pub get` avec flutter (la plupart des IDE s'en chargent automatiquement) pour récupérer la dépendance.

Pour plus de détail, allez voir la [documentation sur les packages](https://dart.dev/tutorials/libraries/shared-pkgs).
