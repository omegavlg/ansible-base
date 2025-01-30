# Домашнее задание к занятию "`Введение в Ansible`" - `Дедюрин Денис`

---
## Задание.

0. Установите Ansible версии 2.10 или выше.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
13. Предоставьте скриншоты результатов запуска команд.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

### Ответ: 

0. Установлен **ansible**:

<img src = "img/01.png" width = 100%>

1. Запускаем **playbook** на окружении из **test.yml**

```
ansible-playbook -i inventory/test.yml site.yml
```

<img src = "img/02.png" width = 100%>

Видим, что **some_fact** равняется значению **12**.

2. Это значение берётся из **group_vars/all/examp.yml**. Изменяем значение на **all default fact**:

```
---
some_fact: "all default fact"
```
Повторяем запуск **playbook**:

<img src = "img/03.png" width = 100%>

3. Подготовлены окружения на базе **docker**

4. Выполняем запуск **playbook** на окружении из **prod.yml**.

```
ansible-playbook -i inventory/prod.yml site.yml
```

<img src = "img/04.png" width = 100%>

 Видим полученные значения **some_fact**:

 Для **centos7**:

```
ok: [centos7] => {
    "msg": "el"
}
```

Для **ubuntu**:

```
ok: [ubuntu] => {
    "msg": "deb"
}
```

5. Обновляем файлы **group_vars/deb/examp.yml** и **group_vars/el/examp.yml**:

**group_vars/deb/examp.yml**

```
---
some_fact: "deb default fact"
```

**group_vars/el/examp.yml**

```
---
some_fact: "el default fact"
```
6. Повторяем запуск **playbook**:

<img src = "img/05.png" width = 100%>

7. При помощи **ansible-vault** шифруем факты в **group_vars/deb** и **group_vars/el** с паролем **netology**.

```
ansible-vault encrypt group_vars/deb/examp.yml
```
```
ansible-vault encrypt group_vars/el/examp.yml
```

<img src = "img/06.png" width = 100%>

