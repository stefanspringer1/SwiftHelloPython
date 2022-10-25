# SwiftHelloPython

Example for using [PythonKit](https://github.com/pvieito/PythonKit) for [Swift](https://www.swift.org).

Arguments: \<path to directory with Python scripts> \<base name of Python script>.

It then uses the function `replaceAllAs` in the Python script to replace all “a” in the text “Aha” by “x”:

```Python
def replaceAllAs(text):
  return text.replace("a", "x")
```

## Crucial calls

Import the Python script:

```Swift
let script = try Python.attemptImport(pythonModule)
```

Call a function of the Python script:

```Swift
let changedText = String(script.replaceAllAs(text))
```

## Using PythonKit on Linux

To use PythonKit on Linux, you have to set the environment variable `PYTHON_LIBRARY`, e.g.:

```bash
export PYTHON_LIBRARY=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/libpython3.6.so
```

Use `find /usr/lib -name *libpython*.so` to search for an appropriate Python library.
