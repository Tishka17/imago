import imagopy

print(f"{imagopy.get_version()=}")
sid = imagopy.alloc_session_id()
print(f"{sid=}")
sid2 = imagopy.alloc_session_id()
print(f"{sid2=}")
imagopy.set_session_id(sid)
print("vvv")
print(f"{imagopy.get_configs()=}")
print(f"{imagopy.get_last_error()=}")
