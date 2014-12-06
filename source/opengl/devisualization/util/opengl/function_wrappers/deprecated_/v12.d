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
module devisualization.util.opengl.function_wrappers.deprecated_.v12;

/*
    alias da_glColorTable = void function( GLenum, GLenum, GLsizei, GLenum, GLenum, const( void )* );
    alias da_glColorSubTable = void function( GLenum, GLsizei, GLsizei, GLenum, GLenum, const( void )* );
    alias da_glColorTableParameteriv = void function( GLenum, GLenum, const( GLint )* );
    alias da_glColorTableParameterfv = void function( GLenum, GLenum, const( GLfloat )* );
    alias da_glCopyColorSubTable = void function( GLenum, GLsizei, GLint, GLint, GLsizei );
    alias da_glCopyColorTable = void function( GLenum, GLenum, GLint, GLint, GLsizei );
    alias da_glGetColorTable = void function( GLenum, GLenum, GLenum, void* );
    alias da_glGetColorTableParameterfv = void function( GLenum, GLenum, GLfloat* );
    alias da_glGetColorTableParameteriv = void function( GLenum, GLenum, GLint* );
    alias da_glHistogram = void function( GLenum, GLsizei, GLenum, GLboolean );
    alias da_glResetHistogram = void function( GLenum );
    alias da_glGetHistogram = void function( GLenum, GLboolean, GLenum, GLenum, void* );
    alias da_glGetHistogramParameterfv = void function( GLenum, GLenum, GLfloat* );
    alias da_glGetHistogramParameteriv = void function( GLenum, GLenum, GLint* );
    alias da_glMinmax = void function( GLenum, GLenum, GLboolean );
    alias da_glResetMinmax = void function( GLenum );
    alias da_glGetMinmax = void function( GLenum, GLboolean, GLenum, GLenum, void* );
    alias da_glGetMinmaxParameterfv = void function( GLenum, GLenum, GLfloat* );
    alias da_glGetMinmaxParameteriv = void function( GLenum, GLenum, GLint* );
    alias da_glConvolutionFilter1D = void function( GLenum, GLenum, GLsizei, GLenum, GLenum, const( void )* );
    alias da_glConvolutionFilter2D = void function( GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, const( void )* );
    alias da_glConvolutionParameterf = void function( GLenum, GLenum, GLfloat );
    alias da_glConvolutionParameterfv = void function( GLenum, GLenum, const( GLfloat )* );
    alias da_glConvolutionParameteri = void function( GLenum, GLenum, GLint );
    alias da_glConvolutionParameteriv = void function( GLenum, GLenum, const( GLint )* );
    alias da_glCopyConvolutionFilter1D = void function( GLenum, GLenum, GLint, GLint, GLsizei );
    alias da_glCopyConvolutionFilter2D = void function( GLenum, GLenum, GLint, GLint, GLsizei, GLsizei );
    alias da_glGetConvolutionFilter = void function( GLenum, GLenum, GLenum, void* );
    alias da_glGetConvolutionParameterfv = void function( GLenum, GLenum, GLfloat* );
    alias da_glGetConvolutionParameteriv = void function( GLenum, GLenum, GLint* );
    alias da_glSeparableFilter2D = void function( GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, const( void )*, const( void )* );
    alias da_glGetSeparableFilter = void function( GLenum, GLenum, GLenum, void*, void*, void* );*/