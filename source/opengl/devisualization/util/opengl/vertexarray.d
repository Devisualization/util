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