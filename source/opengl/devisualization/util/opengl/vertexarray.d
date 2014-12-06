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
module devisualization.util.opengl.vertexarray;
import devisualization.util.opengl.buffers;
import devisualization.util.opengl.shaders;
import glINCOMPLETE = derelict.opengl3.gl3;
import devisualization.util.opengl.function_wrappers;
public import devisualization.util.opengl.function_wrappers : BindBufferTargets;

class VertexArray {
    private {
        uint id_;
    }
    
    this() {
        glINCOMPLETE.glGenVertexArrays(1, cast(uint*)&id_);
        glINCOMPLETE.glBindVertexArray(id_);
    }
    
    ~this() {
        glINCOMPLETE.glDeleteVertexArrays(1, cast(uint*)&id_);
    }
    
    uint opCast(T:uint)() {
        return id_;
    }
    
    void bind() {
        gl.glBindVertexArray(id_);
    }

    void bindAttribute(ShaderProgram program, string attribute, IBuffer buffer, AttribPointerType type, uint count) {
        buffer.bind();
        bindAttribute(program, attribute, type, count);
    }
    
    void bindAttribute(ShaderProgram program, string attribute, AttribPointerType type, uint count) {
        uint attrib = program.getAttribute(attribute);
        gl.glEnableVertexAttribArray(attrib);
        gl.glVertexAttribPointer(attrib, count, type, false, 0, null);
    }
}