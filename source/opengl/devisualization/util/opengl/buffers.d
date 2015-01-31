/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2014 Devisualization (Richard Andrew Cattermole)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
module devisualization.util.opengl.buffers;
import devisualization.util.opengl.function_wrappers;
import devisualization.image;
public import devisualization.util.opengl.function_wrappers : BindBufferTargets, BufferUsages;
public import gl3n.linalg : vec4, vec3, vec2, mat2, mat3, mat34, mat4;

alias Buffer!(BufferUsages.StaticDraw, BindBufferTargets.ArrayBuffer) StandardBuffer;
alias Buffer!(BufferUsages.StaticDraw, BindBufferTargets.ElementArrayBuffer) IndexBuffer;

struct IBuffer {
    private {
        void delegate() bind1;
        void delegate(BindBufferTargets type) bind2;
    }

    void bind() {
        bind1();
    }

    void bind(BindBufferTargets type) {
        bind2(type);
    }
}

class Buffer(BufferUsages _usage, BindBufferTargets _type) {
    private {
        uint id_;
    }

	IBuffer this_;
	alias this_ this;

    this(vec2[] data...) {
        float[] vals;
        foreach(v; data) vals ~= v.vector;
        this(cast(void[])vals);
    }
    
    this(vec3[] data...) {
        float[] vals;
        foreach(v; data) vals ~= v.vector;
        this(cast(void[])vals);
    }
    
    this(vec4[] data...) {
        float[] vals;
        foreach(v; data) vals ~= v.vector;
        this(cast(void[])vals);
    }
    
    this(mat2 data) {this(cast(void[])data.matrix);}
    this(mat3 data) {this(cast(void[])data.matrix);}
    this(mat34 data) {this(cast(void[])data.matrix);}
    this(mat4 data) {this(cast(void[])data.matrix);}
    
    this(Image data) {this(*cast(void[]*)ubyteRawColor(data.rgba.allPixels)[0].ptr);}
    
    this(float[] data...) {this(cast(void[])data);}
    this(ubyte[] data...) {this(cast(void[])data);}
    
    this(void[] data) {
        this_.bind1 = () { bind(); };
        this_.bind2 = &bind;

        id_ = glGenBuffer();
        glBindBuffer(_type, id_);
        glBufferData(_type, data, _usage);
        glBindBuffer(_type, 0);
    }
    
    ~this() {
        glDeleteBuffer(id_);
    }
    
    void opOpAssign(string s)(vec2[] data) {
        float[] vals;
        foreach(v; data) vals ~= v.vector;
        opOpAssign!s(cast(void[])vals);
    }
    
    void opOpAssign(string s)(vec3[] data) {
        float[] vals;
        foreach(v; data) vals ~= v.vector;
        opOpAssign!s(cast(void[])vals);
    }
    
    void opOpAssign(string s)(vec4[] data) {
        float[] vals;
        foreach(v; data) vals ~= v.vector;
        opOpAssign!s(cast(void[])vals);
    }
    
    void opOpAssign(string s)(mat2 data) {opOpAssign!s(cast(void[])data.matrix);}
    void opOpAssign(string s)(mat3 data) {opOpAssign!s(cast(void[])data.matrix);}
    void opOpAssign(string s)(mat34 data) {opOpAssign!s(cast(void[])data.matrix);}
    void opOpAssign(string s)(mat4 data) {opOpAssign!s(cast(void[])data.matrix);}
    
    void opOpAssign(string s)(float[] data) {opOpAssign!s(cast(void[])data);}
    
    void opOpAssign(string s)(void[] data) {
        static if (s != "=") return;
        glBindBuffer(_type, id_);
        glBufferData(_type, data, _usage);
        glBindBuffer(_type, 0);
    }
    
    void[] opSlice(size_t offset, size_t length) {
        void[] data;
        data.length = length;
        glGetBufferSubData(_type, cast(uint)offset, data);
        return data;
    }
    
    uint opCast(T:uint)() {
        return id_;
    }

    void bind(BindBufferTargets type = _type) {
        glBindBuffer(type, id_);
    }
}