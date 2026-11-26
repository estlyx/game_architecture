# Источники и терминология

Источники проверены 20 ноября 2026 года. Код комплекта написан для учебного примера. Он использует общедоступные API Godot и не воспроизводит официальный демопроект.

- Исходная лекция пользователя «Игровой движок как платформа и модульная архитектура (4)»: темы runtime, инструменты, граница игры и движка, модульность и карта Gregory. Новая последовательность заменяет исходный маршрут занятия.
- Gregory, Jason. Game Engine Architecture, 3rd ed., 2018, гл. 1. Сокращённая карта подсистем в лекции является учебной адаптацией, а не точным воспроизведением рисунка книги.
- Godot для macOS: https://godotengine.org/download/macos/
- Движение в 2D: https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html
- CharacterBody2D: https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html
- Ввод и действия: https://docs.godotengine.org/en/stable/tutorials/inputs/input_examples.html
- Сигналы: https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html
- Узлы и сцены: https://docs.godotengine.org/en/stable/getting_started/step_by_step/nodes_and_scenes.html
- Исходный код Godot, для необязательной экскурсии после основного занятия: https://github.com/godotengine/godot

CharacterBody2D не падает под действием гравитации автоматически. В этом проекте игровая логика увеличивает velocity.y, а move_and_slide() выполняет перемещение с обработкой столкновений. Это различие важно сохранить в рассказе.

Сигналы показывают слабую связанность отправителя и получателя. Они сами по себе не доказывают применение DIP. Дерево сцены показывает состав объектов, а не полный граф зависимостей модулей движка.
