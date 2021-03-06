FROM andrewosh/binder-base

MAINTAINER Matthias Kuemmerer <matthias.kuemmerer@bethgelab.org>

USER root

RUN apt-get update && apt-get install -y wget git vim unzip make g++ octave octave-image octave-statistics liboctave-dev
RUN git clone https://github.com/NUS-VIP/salicon-api /opt/salicon-api

USER main

RUN conda install numpy scipy cython theano  natsort dill seaborn
RUN conda install -n python3 numpy scipy cython theano  natsort dill seaborn
RUN pip install hdf5storage git+https://github.com/matthias-k/optpy
RUN /bin/bash -c 'source activate python3  && pip install hdf5storage git+https://github.com/matthias-k/optpy && source deactivate'
ENV PYTHONPATH /opt/salicon-api/PythonAPI:$PYTHONPATH
RUN git clone https://github.com/matthias-k/pysaliency && cd pysaliency && python setup.py install
RUN /bin/bash -c 'source activate python3  && cd pysaliency && python setup.py install && source deactivate && cd .. && rm -rf pysaliency'
RUN mkdir -p /home/main/notebooks/
#ADD utils/predownload.py /home/main/notebooks/
#RUN cd /home/main/notebooks && python predownload.py && rm predownload.py
#RUN /bin/bash -c 'source activate python3  && python utils/predownload.py && source deactivate && cd ..'
RUN cd /home/main/notebooks && wget http://kalliope.matthias-k.org/~matthias/pysaliency/pysaliency-examples-cache.tar.gz && tar xzf pysaliency-examples-cache.tar.gz && rm pysaliency-examples-cache.tar.gz
