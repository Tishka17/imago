cdef extern from "imago_c.h":
    ctypedef unsigned long long qword

    const char *imagoGetVersion()
    const char *imagoGetLastError()
    qword imagoAllocSessionId()
    void imagoSetSessionId(qword id);

    const char*imagoGetConfigsList();

def get_version() -> str:
    return (<bytes> imagoGetVersion()).decode()

def get_last_error() -> str:
    return (<bytes> imagoGetLastError()).decode()

def alloc_session_id() -> int:
    return imagoAllocSessionId()

def set_session_id(session_id: int) -> None:
    return imagoSetSessionId(session_id)

def get_configs()-> str:
    res = imagoGetConfigsList()
    return res.decode()
