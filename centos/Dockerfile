# Этап сборки Python
FROM centos:7 AS builder

# Обновляем зеркала CentOS на Vault
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Устанавливаем EPEL и Development Tools
RUN yum install -y epel-release && \
    yum groupinstall -y "Development Tools"

# Устанавливаем зависимости для Python 3.9
RUN yum install -y gcc gcc-c++ make zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel \
    openssl-devel xz xz-devel libffi-devel wget

# Скачиваем и компилируем Python 3.9 вручную
RUN cd /usr/src && \
    wget https://www.python.org/ftp/python/3.9.18/Python-3.9.18.tgz && \
    tar xvf Python-3.9.18.tgz && \
    cd Python-3.9.18 && \
    ./configure --enable-optimizations && \
    make altinstall

# Этап конечного образа
FROM centos:7

# Копируем скомпилированный Python и необходимые файлы из этапа сборки
COPY --from=builder /usr/local /usr/local

# Создаем симлинки
RUN ln -sf /usr/local/bin/python3.9 /usr/bin/python3 && \
    ln -sf /usr/local/bin/pip3.9 /usr/bin/pip3

# Команда по умолчанию
CMD ["bash"]
