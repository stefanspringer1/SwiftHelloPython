# SwiftHelloPython

Example for using [PythonKit](https://github.com/pvieito/PythonKit) for [Swift](https://www.swift.org).

Arguments: \<path to directory with Python scripts> \<base name of Python script>.

It then uses the function `replaceAllAs` in the Python script to replace all “a” in the text “Aha” by “x”:

```Python
def replaceAllAs(text):
  return text.replace("a", "x")
```

## Crucial calls

As a prerequisite, `PythonKit` has to be added as a dependency of your Swift package, see the `Package.swift` file.

Then, in your Swift program:

Import `PythonKit`:

```Swift
import PythonKit
```

Import the Python script, using `pythonScripts` as the path to directory containing your Python script, and `pythonModule` as the base name of your Python script:

```Swift
let sys = Python.import("sys")
sys.path.append(pythonScripts)
let script = try Python.attemptImport(pythonModule)
```

(You might do not have to use `let sys = Python.import("sys")` and `sys.path.append(pythonScripts)` if your Python script has been installed "in the usual way".)

Call a function of the Python script:

```Swift
let changedText = String(script.replaceAllAs(text))
```

## Referencing the Python library

You set the environment variable `PYTHON_LIBRARY` to reference the according Python library file, on Linux e.g.:

```bash
export PYTHON_LIBRARY=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/libpython3.6.so
```

Use `find /usr/lib -name *libpython*.so` to search for an appropriate Python library on Linux. On macOS, an according library file has the `dylib` extension.

You may not need to set this environment variable on macOS.

**To use a specific Python environment**, reference the Python library file inside the environment.

## Using UTF-8

When using a Python script via PythonKit, Python might run with some "missing" settings. When you need to read UTF-8 encoded files, you need to:

- set `PYTHONIOENCODING`: `export PYTHONIOENCODING=utf-8` on macOS/Linux,
- add the appropriate argument to some calls, e.g. `open(path, 'r', encoding="utf-8")` instead of just `open(path, 'r')`.

## Concurrent calls of Python functions

Note that CPython has the "global interpreter lock" (GIL), so calling into Python scripts concurrently should not work. The GIL [might be removed in future versions of CPython](https://pyfound.blogspot.com/2022/05/the-2022-python-language-summit-python_11.html) (status: end of 2022).

## References

- https://www.tensorflow.org/swift/tutorials/python_interoperability
- https://colab.research.google.com/github/tensorflow/swift/blob/main/docs/site/tutorials/python_interoperability.ipynb

## Related projects

- https://github.com/pvieito/PythonCodable
