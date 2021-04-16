from functools import wraps
cdef extern from "imago_c.h":
    ctypedef unsigned long long qword

    const char *imagoGetVersion();
    const char *imagoGetLastError();

    qword imagoAllocSessionId();
    void imagoSetSessionId(qword id);
    void imagoReleaseSessionId(qword id);

    const char*imagoGetConfigsList();
    int imagoSetConfig(const char *name);

    int imagoSetFilter(const char *name);

    int imagoLoadImageFromFile(const char *FileName);
    int imagoRecognize(int *warningsCountDataOut);

    int imagoSaveMolToFile(const char *fileName);

def get_version() -> str:
    return (<bytes> imagoGetVersion()).decode()

def get_configs()-> str:
    res = imagoGetConfigsList()
    return res.decode()

def set_config(name: str)-> int:
    return imagoSetConfig(name.encode())

def set_filter(name: str)-> int:
    return imagoSetFilter(name.encode())

def _check_error(res):
    if res == 0:
        raise ImagoError((<bytes> imagoGetLastError()).decode())
    return res

def _stateful(func):
    @wraps(func)
    def inner(self, *args, **kwargs):
        self._set_session()
        res = func(self, *args, **kwargs)
        return _check_error(res)
    return inner

class ImagoError(RuntimeError):
    pass


class _BaseImago:
    def __init__(self):
        self._session_id = imagoAllocSessionId()

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        imagoReleaseSessionId(self._session_id)
        self._session_id = None

    def __del__(self):
        if self._session_id is not None:
            imagoReleaseSessionId(self._session_id)

    def _set_session(self):
        _check_error(imagoSetSessionId(self._session_id))


class Imago(_BaseImago):
    @_stateful
    def load_image_from_file(self, path):
        return imagoLoadImageFromFile(str(path).encode())

    @_stateful
    def recognize(self, include_warnings: bool = False) -> int:
        cdef int warns = int(include_warnings)
        return imagoRecognize(&warns)

    @_stateful
    def save_mol_to_file(self, filename: str) -> int:
        return imagoSaveMolToFile(filename.encode())
