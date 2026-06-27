## Публикация образа в Yandex Container Registry

Созданный registry:

```text
ID: crpvq12uvahlel7l4pqb
NAME: test
```

Образ опубликован в registry под тегом:

```text
cr.yandex/crpvq12uvahlel7l4pqb/shvirtd-python:task2
```

Команда сборки и публикации:

```shell
docker buildx build --platform linux/amd64 --provenance=false --sbom=false -t cr.yandex/crpvq12uvahlel7l4pqb/shvirtd-python:task2 -f Dockerfile.python --push .

yc container image list --registry-id  crp593kr8e6uor2mv4jc
```

Проверка, что образ загружен:

```shell
yc container image list --registry-id crpvq12uvahlel7l4pqb
```

Результат:

```text
+----------------------+---------------------+-------------------------------------+------+-----------------+
|          ID          |       CREATED       |                NAME                 | TAGS | COMPRESSED SIZE |
+----------------------+---------------------+-------------------------------------+------+-----------------+
| crpcbemt9gaglh84a93n | 2026-06-27 12:59:52 | crpvq12uvahlel7l4pqb/shvirtd-python | task2 | 88.0 MB         |
+----------------------+---------------------+-------------------------------------+------+-----------------+
```

Примечание: для Docker Desktop использована сборка через `buildx` с `--platform linux/amd64 --provenance=false --sbom=false`, чтобы Yandex Container Registry получил обычный single-platform manifest. Без этого scanner может вернуть ошибку `Image media type is not supported: application/vnd.oci.image.index.v1+json`.

## Сканирование образа

Запуск сканирования:

```shell
yc container image scan crpcbemt9gaglh84a93n
```

Получение последнего отчета:

```shell
yc container image get-last-scan-result --image-id crpcbemt9gaglh84a93n
```

Результат:

```text
id: che5q40qtdg4hg9rn31v
image_id: crpcbemt9gaglh84a93n
scanned_at: "2026-06-27T13:00:38.645Z"
status: READY
vulnerabilities:
  critical: "2"
  high: "9"
  medium: "39"
  low: "63"
  undefined: "36"
```

Просмотр найденных уязвимостей:

```shell
yc container image list-vulnerabilities --scan-result-id che5q40qtdg4hg9rn31v --limit 20
```

Первые строки отчета:

```text
+----------+----------------+--------+--------+--------------+------------------+----------+--------------------------------------------+
| SEVERITY |      NAME      | ORIGIN |  TYPE  |   PACKAGE    |     VERSION      | FIXED BY |                    LINK                    |
+----------+----------------+--------+--------+--------------+------------------+----------+--------------------------------------------+
| CRITICAL | CVE-2026-42496 | os     | debian | perl-base    | 5.40.1-6         |          | https://avd.aquasec.com/nvd/cve-2026-42496 |
| CRITICAL | CVE-2026-8376  | os     | debian | perl-base    | 5.40.1-6         |          | https://avd.aquasec.com/nvd/cve-2026-8376  |
| HIGH     | CVE-2025-69720 | os     | debian | libncursesw6 | 6.5+20250216-2   |          | https://avd.aquasec.com/nvd/cve-2025-69720 |
| HIGH     | CVE-2026-11822 | os     | debian | libsqlite3-0 | 3.46.1-7+deb13u1 |          | https://avd.aquasec.com/nvd/cve-2026-11822 |
| HIGH     | CVE-2026-11824 | os     | debian | libsqlite3-0 | 3.46.1-7+deb13u1 |          | https://avd.aquasec.com/nvd/cve-2026-11824 |
+----------+----------------+--------+--------+--------------+------------------+----------+--------------------------------------------+
```
