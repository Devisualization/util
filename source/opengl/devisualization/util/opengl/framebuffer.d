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
module devisualization.util.opengl.framebuffer;
import devisualization.util.opengl.function_wrappers;
import devisualization.util.opengl.texture;
import glINCOMPLETE = derelict.opengl3.gl3;

class FrameBuffer {
	private {
		uint id_;
	}
	
	this() {
		glINCOMPLETE.glGenFramebuffers(1, &id_);
	}
	
	~this() {
		glINCOMPLETE.glDeleteFramebuffers(1, &id_);
	}

	void bind() {
		glINCOMPLETE.glBindFramebuffer(glINCOMPLETE.GL_DRAW_FRAMEBUFFER, id_);
	}

	void attach(TextureImage texture) {
		glINCOMPLETE.glFramebufferTexture2D(glINCOMPLETE.GL_DRAW_FRAMEBUFFER, glINCOMPLETE.GL_COLOR_ATTACHMENT0, glINCOMPLETE.GL_TEXTURE_2D, texture.id, 0);
	}
	
	@property uint id() {
		return id_;
	}

	static {
		void unbind() {
			glINCOMPLETE.glBindFramebuffer(glINCOMPLETE.GL_DRAW_FRAMEBUFFER, 0);
		}
	}
}