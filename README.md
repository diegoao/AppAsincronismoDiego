# Práctica Programación Reactiva y asincronismo

Práctica realizada para el módulo de Programación Reactiva y Asincronismo por Diego Andrades.

**KeepCoding - Profesor Jose.**

- Para este módulo se ha integrado programación reactiva con Combine y RXSwift.
- Las llamadas de red las se ha realizado con Async Await.
- La UI de login está creada 100% con código.
- Internacionalización de los literales (traducciones) en Español e inglés.
- Se ha implementado testing.
- Patrón de diseño MVVM con todas las capas de Vista, Dominio, y Repository.


## API Reference

#### Obtener todos los items

```http
  https://dragonball.keepcoding.education/api/heros/
```

## Información

La práctica consta de varias pantallas:
| ![Simulador1](https://github.com/diegoao/AppAsincronismoDiego/blob/main/Capturas%20imaganes%20readme/1.png) | ![Simulador2](https://github.com/diegoao/AppAsincronismoDiego/blob/main/Capturas%20imaganes%20readme/2.png) | ![Simulador3](https://github.com/diegoao/AppAsincronismoDiego/blob/main/Capturas%20imaganes%20readme/3.png) | ![Simulador4](https://github.com/diegoao/AppAsincronismoDiego/blob/main/Capturas%20imaganes%20readme/4.png) | ![Simulador5](https://github.com/diegoao/AppAsincronismoDiego/blob/main/Capturas%20imaganes%20readme/5.png) |
| --- | --- | --- | --- | --- | 
| 1 | 2 | 3 | 4 | 5 |

```
1. Login -> Pantalla en la cual tenemos que logearnos.
Previamente tenemos que crearnos un usuario en la API. Si
obtenemos un error al ingresar el usuario o contraseña nos
Llevará a la ventana de error. Si iniciamos sesion no volverá
a salir hasta que pulsemos el botón logOut!
```
```
2. Ventana Error -> Nos muestra error en el usuario
o en la contraseña.
```
```
3. Lista de héroes -> Al obtener el token con nuestro usuario
y contraseña accederemos a la lista de héroes donde podremos
ver todos los personajes incluidos en la Api. Al realizar clic
sobre ellos se nos abrirá la pantalla de transformaciones.
```
```
3.Detalle Héroe -> Podemos ver la foto y una descripción del héroe su localización y en un CollectionView todas sus transformaciones.
```
```
4. Transformación -> Ejemplo cuando un personaje no tiene transformaciones.
```
```
5 Transformación -> Transformaciones Héroes.
```
```

## Autor

- [@Diego](https://github.com/diegoao)
