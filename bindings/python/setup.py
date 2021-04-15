from distutils.core import setup
from distutils.extension import Extension

from Cython.Build import cythonize

examples_extension = Extension(
    name="imagopy",
    sources=["imagopy.pyx"],
    libraries=[
        "imago_c", "imago",
        "opencv_core", "opencv_imgproc", "opencv_imgcodecs",
        "indigo",
    ],
    library_dirs=[
        "../c/imago_static",
        "../../imago",
        "../../imago-third-party/indigo/libs_release/Linux/x64/",
    ],
    include_dirs=[
        "../c/src/",
    ],
    language="c++",  # generate C++ code,
)
setup(
    name="imagopy",
    ext_modules=cythonize(
        [examples_extension],
        compiler_directives={'language_level': "3"}),
)
