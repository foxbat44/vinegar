package main

import (
	"github.com/jwijenbergh/puregotk/v4/gio"
	"github.com/jwijenbergh/puregotk/v4/gobject"
)

type AsyncResult struct {
	Ptr uintptr
}

func AsyncResultFromInternalPtr(ptr uintptr) *AsyncResult {
	return &AsyncResult{
		Ptr: ptr,
	}
}

func (x *AsyncResult) GoPointer() uintptr {
	return x.Ptr
}

func (x *AsyncResult) SetGoPointer(ptr uintptr) {
	x.Ptr = ptr
}

func (x *AsyncResult) GetSourceObject() *gobject.Object {
	cret := gio.XGAsyncResultGetSourceObject(x.GoPointer())
	if cret == 0 {
		return nil
	}

	return &gobject.Object{
		Ptr: cret,
	}
}

func (x *AsyncResult) GetUserData() uintptr {
	return gio.XGAsyncResultGetUserData(x.GoPointer())
}

func (x *AsyncResult) IsTagged(SourceTagVar uintptr) bool {
	return gio.XGAsyncResultIsTagged(x.GoPointer(), SourceTagVar)
}

func (x *AsyncResult) LegacyPropagateError() bool {
	return gio.XGAsyncResultLegacyPropagateError(x.GoPointer())
}
