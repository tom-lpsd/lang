#include <Python.h>

static PyObject *
spam_system(PyObject *self, PyObject *args)
{
    const char *command;
    int sts;

    if (!PyArg_ParseTuple(args, "s", &command))
        return NULL;
    sts = system(command);
    return Py_BuildValue("i", sts);
}

static PyObject *
spam_cb(PyObject *self, PyObject *args)
{
    PyObject *result = NULL;
    PyObject *temp;

    if(PyArg_ParseTuple(args, "O:set_callback", &temp)) {
        if (!PyCallable_Check(temp)) {
            PyErr_SetString(PyExc_TypeError, "parameter must be callable");
            return NULL;
        }
        Py_XINCREF(temp);
        if (PyEval_CallObject(temp, NULL)==NULL)
            return NULL;
        Py_XDECREF(temp);
        Py_INCREF(Py_None);
        result = Py_None;
    }
    return result;
}


static PyMethodDef SpamMethods[] = {
    {"system", spam_system, METH_VARARGS,
     "Execute a shell command."},
    {"cb", spam_cb, METH_VARARGS,
     "example for callback."},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef spammodule = {
    PyModuleDef_HEAD_INIT,
    "spam",
    "spam module",
    -1,
    SpamMethods
};

PyMODINIT_FUNC
PyInit_spam(void)
{
    return PyModule_Create(&spammodule);
}
