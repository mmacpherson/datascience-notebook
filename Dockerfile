# FROM jupyter/tensorflow-notebook
FROM jupyter/datascience-notebook

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
    awscli \
    ed \
    libhdf5-dev \
    libnlopt-dev \
    libomp-dev \
    && rm -rf /var/lib/apt/lists/*


USER $NB_USER
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
    # pelican \
    requests \
    # -- viz
    # altair \
    plotnine \
    # -- data
    feather-format \
    protobuf \
    pymc3 \
    # pystan \
    # pytorch \
    # theano \
    xgboost \
    # -- coding
    flake8 \
    hypothesis \
    jupyter_contrib_nbextensions \
    jupyterlab \
    nbstripout \
    pytest \
    watermark \
    yapf \
    # -- R
    r-caret \
    r-domc \
    r-glmnet \
    r-irkernel \
    r-proc \
    r-rocr \
    r-speedglm \
    r-tidyverse \
    && conda clean -tipsy

# conda install -c mdekstrand r-glmnetutils

# -- install python packages not available in the conda channels above
RUN pip install -U -q pip && \
    pip install -U -q \
        dash \
        dash-core-components \
        dash-html-components \
        dash-renderer \
        edward \
        knotr \
        plotly \
        plydata \
        pysistence \
        git+git://github.com/mmacpherson/cottonmouth.git@master


# -- install R packages not available in the conda channels above
RUN R -e "install.packages(c('interplot', 'glmnetUtils', 'biglasso', 'effects'), repos = 'http://cran.rstudio.com')"
