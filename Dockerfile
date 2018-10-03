# From pytorch compiled from source
FROM pytorch/pytorch

RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends \
        vim 
        
RUN pip --no-cache-dir install \
    jupyter\
    natsort\
    pillow \
    matplotlib \
    torchvision \
    scikit-learn \
    scikit-image \
    pandas \
    h5py \
    tqdm \
    autopep8 \
    fire

## Configure Jupiter notebook extensions

# Set up notebook config
  COPY jupyter_notebook_config.py /root/.jupyter/

# Enable JS widgets
  RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

# Install contributed notebook extensions
  RUN pip install https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master
  RUN jupyter contrib nbextension install --system
  RUN jupyter nbextension enable collapsible_headings/main
  RUN jupyter nbextension enable spellchecker/main

# Install vim bindings
  RUN jupyter nbextension install https://github.com/lambdalisue/jupyter-vim-binding/archive/master.tar.gz --system
  RUN jupyter nbextension enable 
  RUN mkdir -p /root/.jupyter/custom
  COPY custom.js /root/.jupyter/custom


# Expose Ports for Ipython (9999)
EXPOSE 9999

# Move to home dir for root
WORKDIR "/root"

