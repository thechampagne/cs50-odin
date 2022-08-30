/*
 * Copyright (c) 2022 XXIV
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
package cs50

import "core:fmt"
import "core:os"
import "core:io"
import "core:strconv"

Error :: enum {
	// No Error
	None           = 0, 
	// EOF is the error returned by `read` when no more input is available
	EOF, 
	// Unexpected_EOF means that EOF was encountered in the middle of reading a fixed-sized block of data
	Unexpected_EOF, 
	// Short_Write means that a write accepted fewer bytes than requested but failed to return an explicit error
	Short_Write, 
	// Invalid_Write means that a write returned an impossible count
	Invalid_Write, 
	// Short_Buffer means that a read required a longer buffer than was provided
	Short_Buffer, 
	// No_Progress is returned by some implementations of `io.Reader` when many calls
	// to `read` have failed to return any data or error.
	// This is usually a signed of a broken `io.Reader` implementation
	No_Progress, 
	Invalid_Whence, 
	Invalid_Offset, 
	Invalid_Unread, 
	Negative_Read, 
	Negative_Write, 
	Negative_Count, 
	Buffer_Full, 
	// Unknown means that an error has occurred but cannot be categorized
	Unknown,
    False_int,
    False_i8,
    False_i16,
    False_i32,
    False_i64,
    False_i128,
    False_uint,
    False_u8,
    False_u16,
    False_u32,
    False_u64,
    False_u128,
    False_f16,
    False_f32,
    False_f64,
    Invalid_Int,
	// Empty is returned when a procedure has not been implemented for an io.Stream
	Empty          = -1, 
}

@private read_string :: proc(buffer: ^[dynamic]byte, delimiter: byte) -> io.Error {
    reader := io.Byte_Reader{
        os.stream_from_handle(os.stdin)
    }
    for {
        byte, err := io.read_byte(reader)
        if err != io.Error.None {
            return err
        }
        if byte == delimiter {
            break 
        }
        append(buffer, byte)
    }
    return io.Error.None
}

get_int :: proc(str: string) -> (int, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_int(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < -9223372036854775808 || value > 9223372036854775807 {
        return 0, Error.False_int
    }
    return int(value), Error.None
}

get_i8 :: proc(str: string) -> (i8, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_int(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < -128 || value > 127 {
        return 0, Error.False_i8
    }
    return i8(value), Error.None
}

get_i16 :: proc(str: string) -> (i16, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_int(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < -32768 || value > 32767 {
        return 0, Error.False_i16
    }
    return i16(value), Error.None
}

get_i32 :: proc(str: string) -> (i32, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_int(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < -2147483648 || value > 2147483647 {
        return 0, Error.False_i32
    }
    return i32(value), Error.None
}

get_i64 :: proc(str: string) -> (i64, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_i64_maybe_prefixed(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < -9223372036854775808 || value > 9223372036854775807 {
        return 0, Error.False_i64
    }
    return i64(value), Error.None
}

get_i128 :: proc(str: string) -> (i128, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_i128_maybe_prefixed(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < -170141183460469231731687303715884105728 || value > 170141183460469231731687303715884105727 {
        return 0, Error.False_i128
    }
    return i128(value), Error.None
}

get_uint :: proc(str: string) -> (uint, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_uint(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < 0 || value > 18446744073709551615 {
        return 0, Error.False_uint
    }
    return uint(value), Error.None
}

get_u8 :: proc(str: string) -> (u8, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_uint(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < 0 || value > 255 {
        return 0, Error.False_u8
    }
    return u8(value), Error.None
}

get_u16 :: proc(str: string) -> (u16, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_uint(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < 0 || value > 65535 {
        return 0, Error.False_u16
    }
    return u16(value), Error.None
}

get_u32 :: proc(str: string) -> (u32, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_uint(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < 0 || value > 4294967295 {
        return 0, Error.False_u32
    }
    return u32(value), Error.None
}

get_u64 :: proc(str: string) -> (u64, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_u64_maybe_prefixed(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < 0 || value > 18446744073709551615 {
        return 0, Error.False_u64
    }
    return u64(value), Error.None
}

get_u128 :: proc(str: string) -> (u128, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_u128_maybe_prefixed(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < 0 || value > 340282366920938463463374607431768211455 {
        return 0, Error.False_u128
    }
    return u128(value), Error.None
}

get_f16 :: proc(str: string) -> (f16, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_f32(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < -26550.000 || value > 26550.000 {
        return 0, Error.False_f16
    }
    return f16(value), Error.None
}

get_f32 :: proc(str: string) -> (f32, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_f32(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < -120995009510801288598117041834845169254.000 || value > 120995009510801288598117041834845169254.000 {
        return 0, Error.False_f32
    }
    return f32(value), Error.None
}

get_f64 :: proc(str: string) -> (f64, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return 0, Error(err)
    }
    value, ok := strconv.parse_f64(string(buffer[:]))
    delete(buffer)
    if !ok {
        return 0, Error.Invalid_Int
    }
    if value < -12314888469754656622345703426362674345067002060993301299721909563818540153943549822131299932099929515550295433918611287674157538652958819768520530659808276658074331371295432952792065128386707606792714251820118384463689112930555016765139722329044762207873107438653826814637568978295336038306999956243130347500.000 || value > 12314888469754656622345703426362674345067002060993301299721909563818540153943549822131299932099929515550295433918611287674157538652958819768520530659808276658074331371295432952792065128386707606792714251820118384463689112930555016765139722329044762207873107438653826814637568978295336038306999956243130347500.000 {
        return 0, Error.False_f64
    }
    return f64(value), Error.None
}

get_bool :: proc(str: string) -> (bool, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return false, Error(err)
    }
    value, ok := strconv.parse_bool(string(buffer[:]))
    delete(buffer)
    if !ok {
        return false, Error.Invalid_Int
    }
    return value, Error.None
}

get_string :: proc(str: string) -> (string, Error) {
    buffer: [dynamic]byte
    fmt.print(str)
    err := read_string(&buffer,'\n')
    if err != io.Error.None {
        delete(buffer)
        return "", Error(err)
    }
    return string(buffer[:]), Error.None
}