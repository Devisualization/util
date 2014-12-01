module devisualization.util.opengl.shaders;
import devisualization.util.opengl.function_wrappers;
import gl3n.linalg;

class ShaderProgram {
    private {
        uint id_;
        Shader[] shaders;
    }
    
    this(string vert, string frag=null, string geom=null) {
        if (frag is null)
            this(new Shader(vert, ShaderTypes.VertexShader), null, null);
        else if (geom is null)
            this(new Shader(vert, ShaderTypes.VertexShader), new Shader(frag, ShaderTypes.FragmentShader), null);
        else
            this(new Shader(vert, ShaderTypes.VertexShader), new Shader(frag, ShaderTypes.FragmentShader), new Shader(geom, ShaderTypes.GeometryShader));
    }

    this(Shader vert = null, Shader frag = null, Shader geom = null) {
        // allocate the program
        id_ = glCreateProgram();
        if (vert !is null)
            attach(vert, false);
        if (frag !is null)
            attach(frag, false);
        if (geom !is null)
            attach(geom, false);
        link();
        bind();
    }
    
    ~this() {
        // destroy the program
        glDeleteProgram(id_);
    }
    
    void attach(Shader shader, bool linkCall = true) {
        shaders ~= shader;
        // attach the shader
        glAttachShader(id_, cast(uint)shader);
        if (linkCall)
            link();
    }
    
    void detach(Shader shader) {
        Shader[] ret;
        foreach (s; shaders) {
            if (s != shader)
                ret ~= s;
        }
        shaders = ret;
        glDetachShader(id_, cast(uint)shader);
        link();
    }
    
    uint getAttribute(string name) {
        return glGetAttribLocation(id_, name);
    }
    
    uint getUniform(string name) {
        return glGetUniformLocation(id_, name);
    }
    
    uint opCast(T:uint)() {
        return cast(uint)id_;
    }
    
    void bind() {
        glUseProgram(id_);
    }
    
    void uniform(string name, mat2 value, bool transpose = false) {
        bind();
        glUniformMatrix2(getUniform(name), transpose, cast(float[])value.matrix);
    }
    
    void uniform(string name, mat3 value, bool transpose = false) {
        bind();
        glUniformMatrix3(getUniform(name), transpose, cast(float[])value.matrix);
    }
    
    void uniform(string name, mat4 value, bool transpose = false) {
        bind();
        glUniformMatrix4(getUniform(name), transpose, cast(float[])value.matrix);
    }

    void uniform(string name, vec2 value) {
        bind();
        glUniform(getUniform(name), cast(float[])value.vector);
    }
    
    void uniform(string name, vec3 value) {
        bind();
        glUniform(getUniform(name), cast(float[])value.vector);
    }
    
    void uniform(string name, vec4 value) {
        bind();
        glUniform(getUniform(name), cast(float[])value.vector);
    }
    
    void uniform(string name, float[2] value) {
        bind();
        glUniform(getUniform(name), value);
    }
    
    void uniform(string name, float[4] value) {
        bind();
        glUniform(getUniform(name), value);
    }
    
    void uniform(string name, bool value) {
        bind();
        glUniform(getUniform(name), value);
    }
    
    void uniform(string name, int[2] value) {
        bind();
        glUniform(getUniform(name), value);
    }
    
    void uniform(string name, int[4] value) {
        bind();
        glUniform(getUniform(name), value);
    }
    
    void uniform(string name, int value) {
        bind();
        glUniform(getUniform(name), value);
    }
    
    private {
        void link() {
            glLinkProgram(id_);
            
            int res;
            glGetProgram(id_, ProgramObjects.LinkStatus, res);
            if (!res)
                throw new Exception(getInfoLog());
        }
        
        string getInfoLog() {
            int res;
            glGetProgram(id_, ProgramObjects.InfoLogStatus, res);

            if (res > 0) {
                return glGetProgramInfoLog(id_);
            }
            return "";
        }
    }
    
    /**
     * Add uniform infromation get/set
     */
}

class Shader {
    private {
        //ShaderObj id_;
        uint id_;
        ShaderTypes type;
    }
    
    /**
     * Given either the source or filename(asset loader).
     */
    this(string source, ShaderTypes type) {
        // create
        id_ = glCreateShader(type);
        opAssign(source);
        this.type = type;
        compile();
    }
    
    ~this() {
        glDeleteShader(id_);
    }
    
    void opAssign()(string source) {
        // assign
        glShaderSource(id_, source);
        compile();
    }
    
    ShaderTypes opCast(T : ShaderTypes)() {
        return type;
    }
    
    uint opCast(T : uint)() {
        return cast(uint)id_;
    }
    
   private {
        void compile() {
            // compile
            glCompileShader(id_);

            int res;
            glGetShader(id_, ShaderObjects.CompileStatus, res);
            if (!res)
                throw new Exception(getInfoLog());
        }
        
        string getInfoLog() {
            int res;
            glGetShader(id_, ShaderObjects.InfoLogLength, res);
            
            if (res > 0) {
                return glGetProgramInfoLog(id_);
            }
            return "";
        }
    }
}

/*
 * TODO default shaders for vertices, fragment and geometry.
 * Basically meaning default behaviour i.e. they don't exist occurs.
 */