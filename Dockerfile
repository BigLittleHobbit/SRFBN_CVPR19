FROM ubuntu:20.04

#FROM pytorch/pytorch:1.12.0-cuda11.3-cudnn8-devel
RUN ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime
RUN apt-get update && apt-get install apt-file -y && apt-file update && apt-get install -y apt-utils
RUN apt-get install -y git build-essential curl wget software-properties-common zip unzip vim 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt-get install -y nco cdo
RUN wget -O /tmp/anaconda3.sh https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh
RUN bash /tmp/anaconda3.sh -b -p /opt/conda
RUN /opt/conda/condabin/conda init
CMD ["/bin/bash"]
EXPOSE 7000
EXPOSE 5000

RUN apt-get install python3-pip -y

RUN mkdir -p ~/.config/pip
RUN pip3 install --upgrade pip setuptools wheel
RUN pip3 install torch==1.12.0 torchvision==0.13.0  --extra-index-url https://download.pytorch.org/whl/cu116
COPY ./docker/pip.conf ~/.config/pip/

RUN mkdir -p /home/user/Python/packages/
COPY ./ /home/user/Python/packages/SRFBN_CVPR19
WORKDIR /home/
RUN /opt/conda/condabin/conda install matlabengine
RUN pip wheels /home/user/Python/packages/SRFBN_CVPR19/
RUN pip install /home/user/Python/packages/SRFBN_CVPR19/
RUN pip install markupsafe==2.0.1
