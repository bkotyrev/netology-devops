# Grafana. Дополнительное задание

[Условие задания](https://github.com/netology-code/mnt-homeworks/blob/MNT-video/10-monitoring-03-grafana/README.md).

В качестве задания я взял работающий стек с офисного сервера (с обезличенными данными).

## Задание 1. Самостоятельный стенд

Grafana, Prometheus и Alertmanager развернуты через Docker Compose в `/opt/monitoring`. Node Exporter работает на отдельном сервере как служба systemd. Учебный каталог help для этого стенда не использован.

Схема сбора и оповещений:

```text
Node Exporter :9100 ----> Prometheus :9090 ----> Grafana :3000
SMARTctl Exporter :9633 ->      |
                               +----> Alertmanager :9093 ----> Telegram
```

| Компонент | Версия | Результат проверки |
| --- | --- | --- |
| Grafana | 13.0.1+security-01 | Контейнер запущен, database: ok |
| Prometheus | 3.11.3 | Контейнер запущен, четыре цели UP |
| Alertmanager | 0.32.1 | Контейнер запущен, cluster: ready |
| Node Exporter | 1.9.0 | systemd: active/running, enabled |

Prometheus опрашивает два узла с Node Exporter и два SMARTctl Exporter каждые 30 секунд. Срок хранения метрик составляет 60 дней. В конфигурации заданы два адреса Alertmanager, метка `replica` удаляется перед отправкой оповещений.

Служба `prometheus-node-exporter` запускается от пользователя `prometheus`. Параметры читаются из `/etc/default/prometheus-node-exporter`, текущее значение: `ARGS=""`.

### Конфигурации

Сохранены обезличенные копии действующих файлов:

- [Docker Compose](additional-configs/docker-compose.yml).
- [Prometheus](additional-configs/prometheus/prometheus.yml).
- [Правила Node Exporter](additional-configs/prometheus/rules/node_exporter.yml).
- [Правила SMARTctl Exporter](additional-configs/prometheus/rules/smartctl_exporter.yml).
- [Правила ZFS](additional-configs/prometheus/rules/zfs-alerts.yml).
- [Alertmanager и Telegram](additional-configs/alertmanager/alertmanager.yml).
- [Служба Node Exporter](additional-configs/node-exporter/prometheus-node-exporter.service).
- [Параметры Node Exporter](additional-configs/node-exporter/prometheus-node-exporter.default).

Имена узлов заменены на `node-01.example.lan` и `node-02.example.lan`, адреса серверов - на адреса из диапазона `192.0.2.0/24`. Токены, учетные данные прокси, идентификаторы чата и тем удалены. Название Docker-сети заменено на `monitoring_net`.

В Docker Compose используются теги `latest` и внешняя сеть `monitoring_net`. Версии в таблице получены из работающих сервисов.

### Дашборды

Используются Node Exporter Full и SMARTctl Exporter Dashboard. На скриншотах отображаются загрузка CPU, память, сеть, файловые системы, состояние и температура накопителей.

![Node Exporter Full](img/additional/grafana-prometheus-exporter.png)

![SMARTctl Exporter Dashboard](img/additional/grafana-smartctl.png)

## Задание 3. Оповещения в Telegram

Правила вычисляются в Prometheus. Alertmanager группирует события по `alertname`, `instance` и `severity`, затем направляет их в темы Telegram по уровням `info`, `warning` и `critical`.

Параметры маршрутизации:

| Параметр | Значение |
| --- | --- |
| Ожидание первой группы | 30 секунд |
| Интервал обновления группы | 5 минут |
| Повтор уведомления | 4 часа |
| Отправка восстановления | `send_resolved: true` |
| Формат сообщения | HTML |
| Доступ к Telegram | Через HTTP-прокси |

Основные правила:

| Событие | Условие | Выдержка |
| --- | --- | --- |
| Node Exporter недоступен | `up{job="node"} == 0` | 2 минуты |
| Высокая загрузка CPU | Более 85% / 95% | 10 / 5 минут |
| Высокий Load Average | LA 15 на один CPU выше 1.5 | 15 минут |
| Нехватка RAM | Доступно менее 20% / 10% | 10 / 5 минут |
| Нехватка места | Доступно менее 20% / 10% | 10 / 5 минут |
| OOM kill | Рост счетчика за 30 минут | Без выдержки |
| Температура диска | Более 60 / 70 градусов | 5 / 2 минуты |
| ZFS pool недоступен | Состояние online не равно 1 | 2 минуты |

Загружены 20 правил Node Exporter, 9 правил SMARTctl и 5 правил ZFS. На момент проверки все 34 правила имели `health: ok`, состояние `inactive`, ошибок вычисления не было.

Проверка действующих конфигураций:

```text
promtool check config /etc/prometheus/prometheus.yml
SUCCESS: 3 rule files found
node_exporter.yml: SUCCESS, 20 rules
smartctl_exporter.yml: SUCCESS, 9 rules
zfs-alerts.yml: SUCCESS, 5 rules

amtool check-config /etc/alertmanager/alertmanager.yml
SUCCESS: 3 receivers
```

На скриншоте приведены ранее полученные сообщения в Telegram о системных ошибках, OOM и восстановлении служб. Отдельная тестовая отправка через текущую конфигурацию Alertmanager в рамках работы не выполнялась.

![Сообщения в Telegram](img/additional/telegram-alerts.png)
