module devisualization.util.opengl.function_wrappers.v20;
import gl = derelict.opengl3.gl;
import gldepcnst = derelict.opengl3.deprecatedConstants;
import devisualization.util.opengl.function_wrappers.v12;

enum DrawBuffers {
    None = gldepcnst.GL_NONE,
    FrontLeft = gl.GL_FRONT_LEFT,
    FrontRight = gl.GL_FRONT_RIGHT,
    BackLeft = gl.GL_BACK_LEFT,
    BackRight = gl.GL_BACK_RIGHT,
    ColorAttachment0 = gl.GL_COLOR_ATTACHMENT0
}

enum Faces {
    Front = gl.GL_FRONT,
    Back = gl.GL_BACK,
    FrontAndBack = gl.GL_FRONT_AND_BACK
}

enum FaceStencilAction {
    Keep = gl.GL_KEEP,
    Zero = gl.GL_ZERO,
    Replace = gl.GL_REPLACE,
    Incr = gl.GL_INCR,
    IncrWrap = gl.GL_INCR_WRAP,
    Decr = gl.GL_DECR,
    DecrWrap = gl.GL_DECR_WRAP,
    Invert = gl.GL_INVERT
}

enum TestFunctions {
    Never = gl.GL_NEVER,
    Less = gl.GL_LESS,
    LEqual = gl.GL_LEQUAL,
    Greater = gl.GL_GREATER,
    GEqual = gl.GL_GEQUAL,
    Equal = gl.GL_EQUAL,
    NotEqual = gl.GL_NOTEQUAL,
    Always = gl.GL_ALWAYS
}

enum ShaderTypes {
    ComputeShader = gl.GL_COMPUTE_SHADER,
    VertexShader = gl.GL_VERTEX_SHADER,
    TessControlShader = gl.GL_TESS_CONTROL_SHADER,
    TessEvaluationShader = gl.GL_TESS_EVALUATION_SHADER,
    GeometryShader = gl.GL_GEOMETRY_SHADER,
    FragmentShader = gl.GL_FRAGMENT_SHADER
}

enum AttribDataTypes {
    Float = gl.GL_FLOAT,
    FloatVec2 = gl.GL_FLOAT_VEC2,
    FloatVec3 = gl.GL_FLOAT_VEC3,
    FloatVec4 = gl.GL_FLOAT_VEC4,
    FloatMat2 = gl.GL_FLOAT_MAT2,
    FloatMat3 = gl.GL_FLOAT_MAT3,
    FloatMat4 = gl.GL_FLOAT_MAT4,
    FloatMat2x3 = gl.GL_FLOAT_MAT2x3,
    FloatMat2x4 = gl.GL_FLOAT_MAT2x4,
    FloatMat3x2 = gl.GL_FLOAT_MAT3x2,
    FloatMat3x4 = gl.GL_FLOAT_MAT3x4,
    FloatMat4x2 = gl.GL_FLOAT_MAT4x2,
    FloatMat4x3 = gl.GL_FLOAT_MAT4x3,
    Int = gl.GL_INT,
    IntVec2 = gl.GL_INT_VEC2,
    IntVec3 = gl.GL_INT_VEC3,
    IntVec4 = gl.GL_INT_VEC4,
    UInt = gl.GL_UNSIGNED_INT,
    UIntVec2 = gl.GL_UNSIGNED_INT_VEC2,
    UIntVec3 = gl.GL_UNSIGNED_INT_VEC3,
    UIntVec4 = gl.GL_UNSIGNED_INT_VEC4,
    Double = gl.GL_DOUBLE,
    DoubleVec2 = gl.GL_DOUBLE_VEC2,
    DoubleVec3 = gl.GL_DOUBLE_VEC3,
    DoubleVec4 = gl.GL_DOUBLE_VEC4,
    DoubleMat2 = gl.GL_DOUBLE_MAT2,
    DoubleMat3 = gl.GL_DOUBLE_MAT3,
    DoubleMat4 = gl.GL_DOUBLE_MAT4,
    DoubleMat2x3 = gl.GL_DOUBLE_MAT2x3,
    DoubleMat2x4 = gl.GL_DOUBLE_MAT2x4,
    DoubleMat3x2 = gl.GL_DOUBLE_MAT3x2,
    DoubleMat3x4 = gl.GL_DOUBLE_MAT3x4,
    DoubleMat4x2 = gl.GL_DOUBLE_MAT4x2,
    DoubleMat4x3 = gl.GL_DOUBLE_MAT4x3
}

enum ProgramObjects {
    DeleteStatus = gl.GL_DELETE_STATUS,
    LinkStatus = gl.GL_LINK_STATUS,
    ValidateStatus = gl.GL_VALIDATE_STATUS,
    InfoLogStatus = gl.GL_INFO_LOG_LENGTH,
    AttachedShaders = gl.GL_ATTACHED_SHADERS,
    ActiveAttributes = gl.GL_ACTIVE_ATTRIBUTES,
    ActiveAttributeMaxLength = gl.GL_ACTIVE_ATTRIBUTE_MAX_LENGTH,
    ActiveUniforms = gl.GL_ACTIVE_UNIFORMS,
    ActiveUniformMaxLength = gl.GL_ACTIVE_UNIFORM_MAX_LENGTH
}

enum ShaderObjects {
    ShaderType = gl.GL_SHADER_TYPE,
    DeleteStatus = gl.GL_DELETE_STATUS,
    CompileStatus = gl.GL_COMPILE_STATUS,
    InfoLogLength = gl.GL_INFO_LOG_LENGTH,
    ShaderSourceLength = gl.GL_SHADER_SOURCE_LENGTH
}

enum VertexAttributeNames {
    ArrayBufferBindings = gl.GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING,
    ArrayEnabled = gl.GL_VERTEX_ATTRIB_ARRAY_ENABLED,
    ArraySize = gl.GL_VERTEX_ATTRIB_ARRAY_SIZE,
    ArrayStride = gl.GL_VERTEX_ATTRIB_ARRAY_STRIDE,
    ArrayType = gl.GL_VERTEX_ATTRIB_ARRAY_TYPE,
    ArrayNormalized = gl.GL_VERTEX_ATTRIB_ARRAY_NORMALIZED,
    ArrayInteger = gl.GL_VERTEX_ATTRIB_ARRAY_INTEGER,
    ArrayDivisor = gl.GL_VERTEX_ATTRIB_ARRAY_DIVISOR,
    Current = gl.GL_CURRENT_VERTEX_ATTRIB
}

enum AttribPointerSize {
    One = 1,
    Two = 2,
    Three = 3,
    Four = 4,
    BGRA = gl.GL_BGRA
}

enum AttribPointerType {
    Byte = gl.GL_BYTE,
    UByte = gl.GL_UNSIGNED_BYTE,
    Short = gl.GL_SHORT,
    UShort = gl.GL_UNSIGNED_SHORT,
    Int = gl.GL_INT,
    UInt = gl.GL_UNSIGNED_INT,
    HalfFloat = gl.GL_HALF_FLOAT,
    Float = gl.GL_FLOAT,
    Double = gl.GL_DOUBLE,
    Fixed = gl.GL_FIXED,
    Int2101010REV = gl.GL_INT_2_10_10_10_REV, 
    UInt2101010Rev = gl.GL_UNSIGNED_INT_2_10_10_10_REV,
    UInt10F11F11FRev = gl.GL_UNSIGNED_INT_10F_11F_11F_REV 
}

void glBlendEquationSeparate(BlendMode modeRGB, BlendMode modeAlpha) {
    gl.glBlendEquationSeparate(cast(gl.GLenum)modeRGB, cast(gl.GLenum)modeAlpha);
}

void glDrawBuffers(int n, DrawBuffers[] bufs) {
    gl.glDrawBuffers(n, cast(gl.GLenum*)bufs.ptr);
}

void glStencilOpSeparate(Faces face, FaceStencilAction sfail, FaceStencilAction dpfail, FaceStencilAction dppass) {
    gl.glStencilOpSeparate(cast(gl.GLenum)face, cast(gl.GLenum)sfail, cast(gl.GLenum)dpfail, cast(gl.GLenum)dppass);
}

void glStencilFuncSeparate(Faces face, TestFunctions func, int ref_, uint mask) {
    gl.glStencilFuncSeparate(cast(gl.GLenum)face, cast(gl.GLenum)func, ref_, mask);
}

void glStencilMaskSeparate(Faces face, uint mask) {
    gl.glStencilMaskSeparate(cast(gl.GLenum)face, mask);
}

void glAttachShader(uint program, uint shader) {
    gl.glAttachShader(program, shader);
}

void glBindAttribLocation(uint program, uint index, string name) {
    gl.glBindAttribLocation(program, index, (name ~ 0).ptr);
}

void glCompileShader(uint shader) {
    gl.glCompileShader(shader);
}

uint glCreateProgram() {
    return gl.glCreateProgram();
}

uint glCreateShader(ShaderTypes shaderType) {
    return gl.glCreateShader(cast(gl.GLenum)shaderType);
}

void glDeleteProgram(uint program) {
    gl.glDeleteProgram(program);
}

void glDeleteShader(uint shader) {
    gl.glDeleteShader(shader);
}

void glDetachShader(uint program, uint shader) {
    gl.glDetachShader(program, shader);
}

void glDisableVertexAttribArray(uint index) {
    gl.glDisableVertexAttribArray(index);
}

void glEnableVertexAttribArray(uint index) {
    gl.glEnableVertexAttribArray(index);
}

void glGetActiveAttrib(uint program, uint index, out int* size, out AttribDataTypes type, out string name) {
    gl.glGetActiveAttrib(program, index, int.max,  cast(int*)null, size, cast(gl.GLenum*)&type, cast(char*)name.ptr);
    name = name[0 .. $-1];
}

void glGetActiveUniform(uint program, uint index, out int size, out AttribDataTypes type, out string name) {
    gl.glGetActiveUniform(program, index, int.max,  cast(int*)null, &size, cast(gl.GLenum*)&type, cast(char*)name.ptr);
    name = name[0 .. $-1];
}

void glGetAttachedShaders(uint program, out uint[] shaders) {
    int* count;
    gl.glGetAttachedShaders(program, int.max, count, shaders.ptr);
}

int glGetAttribLocation(uint program, string name) {
    return gl.glGetAttribLocation(program, (name ~ 0).ptr);
}

void glGetProgram(uint program, ProgramObjects pname, out int params) {
    gl.glGetProgramiv(program, cast(gl.GLenum)pname, &params);
}

void glGetProgram(uint program, ProgramObjects pname, out int[] params) {
    gl.glGetProgramiv(program, cast(gl.GLenum)pname, params.ptr);
}

string glGetProgramInfoLog(uint program) {
    string ret;
    int* length;
    gl.glGetProgramInfoLog(program, int.max, length, cast(char*)ret.ptr);
    return ret[0 .. $-1];
}

void glGetShader(uint shader, ShaderObjects pname, out int params) {
    gl.glGetShaderiv(shader, cast(gl.GLenum)pname, &params);
}

void glGetShader(uint shader, ShaderObjects pname, out int[] params) {
    gl.glGetShaderiv(shader, cast(gl.GLenum)pname, params.ptr);
}

void glGetShaderInfoLog(uint shader, string infoLog) {
    int* length;
    gl.glGetShaderInfoLog(shader, int.max, length, cast(char*)infoLog.ptr);
    infoLog = infoLog[0 .. $-1];
}

void glGetShaderSource(uint shader, out string source) {
    int* length;
    gl.glGetShaderInfoLog(shader, int.max, length, cast(char*)source.ptr);
    source = source[0 .. $-1];
}

int glGetUniformLocation(uint program, string name) {
    return gl.glGetUniformLocation(program, cast(char*)(name ~ 0).ptr);
}

void glGetUniform(uint program, int location, float[] params) {
    gl.glGetUniformfv(program, location, params.ptr);
}

void glGetUniform(uint program, int location, int[] params) {
    gl.glGetUniformiv(program, location, params.ptr);
}

void glGetVertexAttrib(uint index, VertexAttributeNames pname, double[] params) {
    gl.glGetVertexAttribdv(index, cast(gl.GLenum)pname, params.ptr);
}

void glGetVertexAttrib(uint index, VertexAttributeNames pname, float[] params) {
    gl.glGetVertexAttribfv(index, cast(gl.GLenum)pname, params.ptr);
}

void glGetVertexAttrib(uint index, VertexAttributeNames pname, int[] params) {
    gl.glGetVertexAttribiv(index, cast(gl.GLenum)pname, params.ptr);
}

void glGetVertexAttribPointer(uint index, out void*[] pointer) {
    gl.glGetVertexAttribPointerv(index, gl.GL_VERTEX_ATTRIB_ARRAY_POINTER, pointer.ptr);
}

bool glIsProgram(uint program) {
    return cast(bool)gl.glIsProgram(program);
}

bool glIsShader(uint shader) {
    return cast(bool)gl.glIsShader(shader);
}

void glLinkProgram(uint program) {
    gl.glLinkProgram(program);
}

void glShaderSource(uint shader, string _string) {
    if (_string[$-1] != 0) _string ~= 0;
    size_t length = _string.length;
    auto str = _string.ptr;
    gl.glShaderSource(shader, 1, cast(const(gl.GLchar*)*)&str, cast(const(int)*)&length);
}

void glUseProgram(uint program) {
    gl.glUseProgram(program);
}

void glUniform(int location, float v0) {
    gl.glUniform1f(location, v0);
}

void glUniform(int location, float v0, float v1) {
    gl.glUniform2f(location, v0, v1);
}

void glUniform(int location, float v0, float v1, float v2) {
    gl.glUniform3f(location, v0, v1, v2);
}

void glUniform(int location, float v0, float v1, float v2, float v3) {
    gl.glUniform4f(location, v0, v1, v2, v3);
}

void glUniform(int location, int v0) {
    gl.glUniform1i(location, v0);
}

void glUniform(int location, int v0, int v1) {
    gl.glUniform2i(location, v0, v1);
}

void glUniform(int location, int v0, int v1, int v2) {
    gl.glUniform3i(location, v0, v1, v2);
}

void glUniform(int location, int v0, int v1, int v2, int v3) {
    gl.glUniform4i(location, v0, v1, v2, v3);
}

void glUniform(int location, float[] value)
in {
    assert(value.length >= 1 && value.length <= 4);
} body {
    if (value.length == 1)
        gl.glUniform1fv(location, cast(int)value.length, value.ptr);
    else if (value.length == 2)
        gl.glUniform2fv(location, cast(int)value.length, value.ptr);
    else if (value.length == 3)
        gl.glUniform3fv(location, cast(int)value.length, value.ptr);
    else if (value.length == 4)
        gl.glUniform4fv(location, cast(int)value.length, value.ptr);
}

void glUniform(int location, int[] value)
in {
    assert(value.length >= 1 && value.length <= 4);
} body {
    if (value.length == 1)
        gl.glUniform1iv(location, cast(int)value.length, value.ptr);
    else if (value.length == 2)
        gl.glUniform2iv(location, cast(int)value.length, value.ptr);
    else if (value.length == 3)
        gl.glUniform3iv(location, cast(int)value.length, value.ptr);
    else if (value.length == 4)
        gl.glUniform4iv(location, cast(int)value.length, value.ptr);
}

void glUniform(int location, uint[] value)
in {
    assert(value.length >= 1 && value.length <= 4);
} body {
    if (value.length == 1)
        gl.glUniform1uiv(location, cast(int)value.length, value.ptr);
    else if (value.length == 2)
        gl.glUniform2uiv(location, cast(int)value.length, value.ptr);
    else if (value.length == 3)
        gl.glUniform3uiv(location, cast(int)value.length, value.ptr);
    else if (value.length == 4)
        gl.glUniform4uiv(location, cast(int)value.length, value.ptr);
}

void glUniformMatrix2(int location, bool transpose, float[] value) {
    gl.glUniformMatrix2fv(location, cast(int)(value.length / 4), cast(ubyte)(transpose ? gl.GL_TRUE : gl.GL_FALSE), value.ptr);
}

void glUniformMatrix3(int location, bool transpose, float[] value) {
    gl.glUniformMatrix3fv(location, cast(int)(value.length / 9), cast(ubyte)(transpose ? gl.GL_TRUE : gl.GL_FALSE), value.ptr);
}

void glUniformMatrix4(int location, bool transpose, float[] value) {
    gl.glUniformMatrix4fv(location, cast(int)(value.length / 16), cast(ubyte)(transpose ? gl.GL_TRUE : gl.GL_FALSE), value.ptr);
}

void glValidateProgram(uint program) {
    gl.glValidateProgram(program);
}

void glVertexAttrib(uint index, double v0) {
    gl.glVertexAttrib1d(index, v0);
}

void glVertexAttrib(uint index, float v) {
    gl.glVertexAttrib1f(index, v);
}

void glVertexAttrib(uint index, short v0) {
    gl.glVertexAttrib1s(index, v0);
}

void glVertexAttrib(uint index, double v0, double v1) {
    gl.glVertexAttrib2d(index, v0, v1);
}

void glVertexAttrib(uint index, double[2] v) {
    gl.glVertexAttrib2dv(index, v.ptr);
}

void glVertexAttrib(uint index, float v0, float v1) {
    gl.glVertexAttrib2f(index, v0, v1);
}

void glVertexAttrib(uint index, float[2] v) {
    gl.glVertexAttrib2fv(index, v.ptr);
}

void glVertexAttrib(uint index, short v0, short v1) {
    gl.glVertexAttrib2s(index, v0, v1);
}

void glVertexAttrib(uint index, short[2] v) {
    gl.glVertexAttrib2sv(index, v.ptr);
}

void glVertexAttrib(uint index, double v0, double v1, double v2) {
    gl.glVertexAttrib3d(index, v0, v1, v2);
}

void glVertexAttrib(uint index, double[3] v) {
    gl.glVertexAttrib3dv(index, v.ptr);
}

void glVertexAttrib(uint index, float v0, float v1, float v2) {
    gl.glVertexAttrib3f(index, v0, v1, v2);
}

void glVertexAttrib(uint index, float[3] v) {
    gl.glVertexAttrib3fv(index, v.ptr);
}

void glVertexAttrib(uint index, short v0, short v1, short v2) {
    gl.glVertexAttrib3s(index, v0, v1, v2);
}

void glVertexAttrib(uint index, short[3] v) {
    gl.glVertexAttrib3sv(index, v.ptr);
}

/*
bindGLFunc(cast(void**)&glVertexAttrib4Nbv, "glVertexAttrib4Nbv");
bindGLFunc(cast(void**)&glVertexAttrib4Niv, "glVertexAttrib4Niv");
bindGLFunc(cast(void**)&glVertexAttrib4Nsv, "glVertexAttrib4Nsv");
bindGLFunc(cast(void**)&glVertexAttrib4Nub, "glVertexAttrib4Nub");
bindGLFunc(cast(void**)&glVertexAttrib4Nubv, "glVertexAttrib4Nubv");
bindGLFunc(cast(void**)&glVertexAttrib4Nuiv, "glVertexAttrib4Nuiv");
bindGLFunc(cast(void**)&glVertexAttrib4Nusv, "glVertexAttrib4Nusv");
bindGLFunc(cast(void**)&glVertexAttrib4bv, "glVertexAttrib4bv");
bindGLFunc(cast(void**)&glVertexAttrib4d, "glVertexAttrib4d");
bindGLFunc(cast(void**)&glVertexAttrib4dv, "glVertexAttrib4dv");*/

void glVertexAttrib(uint index, float v0, float v1, float v2, float v3) {
    gl.glVertexAttrib4f(index, v0, v1, v2, v3);
}

void glVertexAttrib(uint index, float[4] v) {
    gl.glVertexAttrib4fv(index, v.ptr);
}

/*
bindGLFunc(cast(void**)&glVertexAttrib4iv, "glVertexAttrib4iv");
bindGLFunc(cast(void**)&glVertexAttrib4s, "glVertexAttrib4s");
bindGLFunc(cast(void**)&glVertexAttrib4sv, "glVertexAttrib4sv");
bindGLFunc(cast(void**)&glVertexAttrib4ubv, "glVertexAttrib4ubv");
bindGLFunc(cast(void**)&glVertexAttrib4uiv, "glVertexAttrib4uiv");
bindGLFunc(cast(void**)&glVertexAttrib4usv, "glVertexAttrib4usv");*/

void glVertexAttribPointer(uint index, AttribPointerSize size, AttribPointerType type, bool normalized, int stride, void* pointer) {
    gl.glVertexAttribPointer(index, size, type, normalized ? gl.GL_TRUE : gl.GL_FALSE, stride, pointer);
}