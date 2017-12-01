FROM jupyter/tensorflow-notebook

# -- from the docs:
#    tensorflow-notebook inherits from scipy-notebook, which provides:
#
#    beautifulsoup
#    bokeh
#    cloudpickle
#    cython
#    dill
#    jupyter
#    matplotlib
#    numba
#    numpy
#    pandas
#    patsy
#    scikit-image
#    scikit-learn
#    scipy
#    seaborn
#    statsmodels
#    sympy
#    vincent
#
#    (https://github.com/jupyter/docker-stacks/tree/master/scipy-notebook)
#
#
#    then the tensorflow notebook adds
#
#    keras
#    tensorflow
#
#    (https://github.com/jupyter/docker-stacks/tree/master/tensorflow-notebook)

MAINTAINER Mike Macpherson <mmacpherson@users.noreply.github.com>

USER root
RUN apt-get update && apt-get install -y \
    awscli

USER jovyan
# -- upgrade everything
#    (relies on earlier-configured conda channels: first conda-forge, then defaults)
RUN conda update --all --quiet --yes


# -- add packages available in conda
#    (relies on earlier-configured conda channels: first conda-forge, then defaults)
RUN conda install --quiet --yes \
    # -- general
    boto3 \
    dask \
    ipython \
    luigi \
    click \
    # -- web/net
    bottle \
    flask \
    pelican \
    requests \
    # -- viz
    altair \
    plotnine \
    # -- data
    feather-format \
    pymc3 \
    pystan \
    pytorch \
    theano \
    xgboost \
    # -- coding
    flake8 \
    hypothesis \
    jupyter_contrib_nbextensions \
    nbstripout \
    pytest \
    watermark \
    yapf \
    && conda clean -tipsy

# -- install packages not available in the conda channels above
RUN pip install -U -q pip && \
    pip install -U -q \
        edward \
        dfply \
        dplython \
        plydata \
        pysistence \
        statik \
        git+git://github.com/mmacpherson/cottonmouth.git@master

RUN apt 
