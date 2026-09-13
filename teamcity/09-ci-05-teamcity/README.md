# Домашнее задание «TeamCity»

Репозиторий с решением: [bkotyrev/example-teamcity](https://github.com/bkotyrev/example-teamcity).

## Подготовка инфраструктуры

В Yandex Cloud созданы виртуальные машины `teamcity-server`, `teamcity-agent` и `nexus`.

![Виртуальные машины Yandex Cloud](img/8Gd5d9UGyO.png)

Сделан fork исходного репозитория, запущен playbook из `infrastructure`.

## Проект TeamCity и Maven (пп. 1-8)

Автоопределение конфигурации не сработало, Maven сконфигурирован вручную. Первая сборка `master` завершилась успешно.

![Успешная первая сборка master](img/eV5kmEvIN2.png)

Настроены условия запуска:

- `master` - `clean deploy`;
- остальные ветки - `clean test`.

В поле **Goals** указаны `clean deploy` и `clean test` без префикса `mvn`, так как Maven Runner запускает Maven самостоятельно.

В корневом `pom.xml` указан адрес Nexus. Первая публикация `plaindoll:0.1.0` выполнена в репозиторий `maven-releases`.

![Артефакты plaindoll в Nexus](img/f62t63onsF.png)

## Правки кода приложения (пп. 9-14)

Создана ветка `feature/add_reply`. В класс `Welcomer` добавлен метод `sayGoodbye()` и поправлены тесты.

В `WelcomerTest` добавлена проверка результата метода на наличие `hunter`.

![Сборки master и feature/add_reply](img/kCmOU1BOjd.png)

## Артефакты TeamCity и повторная сборка (пп. 15-18)

До настройки artifact paths в сборке `master` пользовательские артефакты отсутствовали.

![Сборка master без артефактов](img/LadTZmLiBU.png)

В General Settings добавлено правило:

```text
target/*.jar
```

Версия приложения изменена на `0.1.1`. После повторной сборки `master` во вкладке **Artifacts** появились:

- `plaindoll-0.1.1.jar`;
- `original-plaindoll-0.1.1.jar`.

![JAR-файлы в артефактах TeamCity](img/lTh9yJ0sEd.png)


## Результат

Артефакты нескольких версий в Maven.

![Артефакты нескольких версий в Maven](img/ESWfkO60AN.png)
