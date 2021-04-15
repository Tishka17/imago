# cdef extern from "molecule.h" namespace "imago":
#     cdef cppclass Molecule:
#         Molecule()
#         void clear();
#
# cdef class PyMolecule:
#     cdef Molecule *thisptr  # hold a C++ instance which we're wrapping
#     def __cinit__(self):
#         self.thisptr = new Molecule()
#     def __dealloc__(self):
#         del self.thisptr
#
#     def clear(self):
#         return self.thisptr.clear()


cdef extern from "imago_c.h":
    const char *imagoGetVersion()

def get_version() -> str:
    return (<bytes>imagoGetVersion()).decode()
