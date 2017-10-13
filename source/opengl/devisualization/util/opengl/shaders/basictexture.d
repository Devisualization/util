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
module devisualization.util.opengl.shaders.basictexture;
import devisualization.util.opengl.shaders.defs;
import devisualization.util.opengl.vertexarray;
import devisualization.util.opengl.buffers;
import gl3n.linalg : vec4, mat4;
deprecated("de_util:opengl is going to die"):

/**
 * Renders vertices with a texture
 * 
 * Shader based upon https://github.com/fogleman/pg/blob/master/pg/programs.py
 */
class BasicTextureShader : ShaderProgram {
	this() {
		super("""
#if __VERSION__ > 120
    #version 130
    in vec4 position;
    in vec2 uv;
    out vec2 frag_uv;
#else
    #version 120
    attribute vec4 position;
    attribute vec2 uv;
    varying vec2 frag_uv;
#endif

uniform vec4 move;
uniform mat4 scale;
uniform mat4 transform;

void main() {
    gl_Position = ((scale * position) + move) * transform;
    frag_uv = uv;
}
			""",
			"""
#if __VERSION__ > 120
    #version 130
    uniform sampler2D sampler;
    uniform vec4 color;

    in vec2 frag_uv;
    out vec4 outColor;
	void main() {
	    vec4 color = texture2D(sampler, frag_uv);
	    if (color.a == 0) {
	        discard;
	    }
	    outColor = color;
	}
#else
    #version 120
    uniform sampler2D sampler;
    uniform vec4 color;

    varying vec2 frag_uv;
	void main() {
	    vec4 color = texture2D(sampler, frag_uv);
	    if (color.a == 0) {
	        discard;
	    }
	    gl_FragColor = color;
	}
#endif
		""");
	}

	@disable {
		this(string vert, string frag=null, string geom=null){}
		this(Shader vert = null, Shader frag = null, Shader geom = null){}
	}

	@property {
		void move(vec4 v) {
			uniform("move", v);
		}
		
		void scale(mat4 m) {
			uniform("scale", m);
		}
		
		void transform(mat4 m) {
			uniform("transform", m);
		}

		void myVertices(VertexArray vao, IBuffer buffer) {
			import devisualization.util.opengl.function_wrappers.v20 : AttribPointerType;
			vao.bindAttribute(this, "position", buffer, AttribPointerType.Float, 4);
		}

		void myTextureCoordinates(VertexArray vao, IBuffer buffer) {
			import devisualization.util.opengl.function_wrappers.v20 : AttribPointerType;
			vao.bindAttribute(this, "uv", buffer, AttribPointerType.Float, 2);
		}
	}
}