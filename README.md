# testRepositoty

В данном Dockerfile на базе образа Ubuntu:18.04 устанавливаются программы:
- samtools;
- biobambam2.

Для формирования образа необходимо:
- перейти в папку, где находится Dockerfile (cd PATH);
- запустить команду docker build -t testdocker/test PATH, где PATH - путь к Dockerfile.

Для запуска контейнера необходимо запустить команду:
- docker run --rm -t -i testdocker/test.

После запуска контейнера, чтобы убелиться в работоспособности программ, можно их запустить:
- samtools --help
- bamsort -h

Программы доступны из любой папки.
