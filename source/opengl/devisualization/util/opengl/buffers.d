module devisualization.util.opengl.buffers;
import devisualization.util.opengl.function_wrappers;
import devisualization.image;
public import devisualization.util.opengl.function_wrappers : BindBufferTargets, BufferUsages;
public import gl3n.linalg : vec4, vec3, vec2, mat2, mat3, mat34, mat4;

alias Buffer!(BufferUsages.StaticDraw, BindBufferTargets.ArrayBuffer) StandardBuffer;

struct Buffer(BufferUsages _usage, BindBufferTargets _type) {
    private {
        uint id_;
    }
    
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
        glGetBufferSubData(_type, offset, data);
        return data;
    }
    
    uint opCast(T:uint)() {
        return id_;
    }
    
    public {
        void bind(BindBufferTargets type = _type) {
            gl.glBindBuffer(type, id_);
        }
    }
}