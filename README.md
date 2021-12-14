# Автоматизация установки Kubernetes кластера 

За основу проекта была взята статья https://habr.com/ru/post/574514/ "Автоматизация установки Kubernetes кластера с помощью Kubespray и Terraform в Yandex Cloud".

Код был форкнут из репозитория https://github.com/patsevanton/kubespray_terraform_yandex_cloud 

[Yandex.Cloud](url) - облачная платформа Яндекса.

[Kubespray](url) — это набор Ansible ролей для установки и конфигурации системы оркестрации контейнерами Kubernetes.

[Kubernetes](url) (K8s) - это открытое программное обеспечение для автоматизации развёртывания, масштабирования и управления контейнеризированными приложениями.

## Установка Yandex.Cloud (CLI) 
```
$ curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
```

## Установка binenv
[Binenv](https://github.com/devops-works/binenv)

## Установка Terraform 
[Terraform](https://www.terraform.io/)
```
$ binenv install terraform
```

## Установка Kubectl
[Kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/) 
```
$ binenv install kubectl
```

## Установка Helm
[Helm](https://helm.sh/)
```
$ binenv install helm
```

## Установка jq
[JQ](https://stedolan.github.io/jq/) - утилита для анализа, фильтрации, сравния и преобразовывания данных JSON.

```
$ sudo apt install jq
```

## Установка pip3 и git
```
$ sudo apt install python3-pip git
```

## Скачаем Kubespray и установим зависимости
```
$ wget https://github.com/kubernetes-sigs/kubespray/archive/refs/tags/v2.17.1.tar.gz
$ tar -xvzf v2.17.1.tar.gz
$ mv kubespray-2.17.1 kubespray
$ sudo pip3 install -r kubespray/requirements.txt
```

## Настроим Terraform переменные для доступа к Yandex Cloud
```
$ cp terraform/private.auto.tfvars.example terraform/private.auto.tfvars
$ yc config list
$ vim terraform/private.auto.tfvars
```

## Создадим ключи если их нет и поместим в каталог .ssh
```
ssh-keygen -t rsa -b 4096
```
## Для разворота в кластере возьмем "Online Boutique".
[Online Boutique](https://github.com/GoogleCloudPlatform/microservices-demo) - это облачное микросервисное демонстрационное приложение

## Создание ресурсов в Yandex Cloud и установка Kubernetes кластера с помощью Kubespray
```
$ bash cluster_install.sh
```

# Развертывание стека приложений в кластере
```
$ bash app_install.sh
```
После развертывание в Yandex.Cloud
установленные приложения доступны по следующим адресам:

 [Online Boutique](http://9melon.ru)
 [Prometheus](http://prometheus.9melon.ru)
 [Grafana](http://grafana.9melon.ru)

# Удаление кластера kubernetes и ресурсов в Yandex Cloud
```
$ bash cluster_destroy.sh
```