# SwiftHelloPython

Example for using PythonKit

Arguments: \<path to directory with Python scripts> \<base name of Python script>.

It then uses the function `replaceAllAs` in the Python script to replace all “a” in the text “Aha” by “x”:

```Python
def replaceAllAs(text):
  return text.replace("a", "x")
```

To use PythonKit on Linux, you have to set the environment variable `PYTHON_LIBRARY`, e.g.:

```bash
export PYTHON_LIBRARY=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/libpython3.6.so
./SwiftHelloPython/.build/release/HelloPython python-scripts script1
```

Use `find /usr/lib -name *libpython*.so` to search for an appropriate Python library.
