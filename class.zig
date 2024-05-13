
// Const
pub const std = @import("std");

pub const fmt = std.fmt;
pub const io = std.io;
pub const mem = std.mem;
pub const debug = std.debug;
pub const assert = debug.assert;
pub const stdout = io.getStdOut().writer();
pub const tst = std.time.timestamp;


// Types
pub const Array = std.ArrayList;
pub const HashMap = std.AutoHashMap;
pub const HashArray = std.AutoArrayHashMap;
pub const StringMap = std.StringHashMap;


// Gvar
//pub var bw = io.bufferedWriter(stdout);
//pub const bw_stdout = bw.writer();
//    try bw.flush(); // don't forget to flush!
pub var dbg = false;


// Helper methods
pub fn deb(comptime s: anytype, d: anytype) void {
    if (!dbg) return;

//  for (std.meta.fields(@TypeOf(items)) |field| {
//    const value = @field(items, field.name); 
//
//  }

    debug.print(s ++ ": {any}\n", .{d});
}

pub fn puts(comptime ll: anytype, d: anytype) void {
    
    const l = if (ll.len > 0) ll ++ ": " else ll;

    debug.print(l ++ "{s}\n", .{d});
}

pub fn putc(comptime ll: anytype, d: anytype) void {
    
    const l = if (ll.len > 0) ll ++ ": " else ll;

    debug.print(l ++ "{c}\n", .{d});
}

pub fn putd(comptime ll: anytype, d: anytype) void {

    const l = if (ll.len > 0) ll ++ ": " else ll;

    debug.print(l ++ "{d}\n", .{d});
}

pub fn err(comptime l: anytype, d: anytype) !void {
    dbg = true;

    const s = "\nError[" ++ l ++ "]";

    deb(s, d);

    debug.print("\n", .{});

    return error.err;
}

pub fn wip() !void {
    try err("wip", .{});
}

pub fn res(d: anytype) void {
    stdout.print("\n => {}\n\n", .{d}) catch {};
}


// Args //
pub fn ini(al: anytype, tf: anytype, np: *u64) ![]u8 {

    var args = std.process.args();

    _ = args.skip();
    
    const f = args.next() orelse tf;

    if (f.len == 0) {
        try err("Missing Arg: Filename", null);
    }

    const d = try std.fs.cwd().readFileAlloc(al, f, std.math.maxInt(usize));

//    puts("data", d);

    const a = args.next();

    if (a) |n| {
        const v = fmt.parseUnsigned(u64, n, 10) catch |e| {
            err("Invalid int", n) catch {};

            return e;
        };

        np.* = v;
    }

    return d;
}

pub fn lin(comptime l: anytype, i: anytype) void {

    if (!dbg) return;

    if (l.len < 3) {
        const k = 3 - l.len;

        for (0..k) |_| debug.print(" ", .{});
    }
    debug.print(l ++ ": ", .{});

    for (0..i) |_| {
        debug.print(" ", .{});
    }

    debug.print("^ {}\n", .{i});
}


pub fn eut(comptime l: anytype, f: anytype, s: ?[]i64,
    c: anytype
) !void {
    dbg = true;

    out(l, f, s, c);
    try err("", null);
}

pub fn eut2(comptime l: anytype, f: anytype, s: ?[]i64,
    c: anytype
) !void {
    dbg = true;

    out2(l, f, s, c);
    try err("", null);
}

pub fn out(comptime l: anytype, f: anytype, s: ?[]i64, c: anytype) void {
    if (!dbg) return;

    if (l.len < 3) {
        const k = 3 - l.len;

        for (0..k) |_| debug.print(" ", .{});
    }
    debug.print(l ++ ": ", .{});

    for (f.items) |t| {

        const v = c(t);

        debug.print("{c}", .{v});
    }

    if (s) |ss| {
        debug.print(" <- ", .{});

        for (ss) |v| {
            debug.print("{} ", .{v});
        }
    }
    debug.print("\n", .{});
}

pub fn out2(comptime l: anytype, d: anytype, s: anytype, c: anytype) void {
    if (!dbg) return;

    var f: bool = true;

    for (d.items()) |r| {

        if (f) {
            out(l, r, s, c);
            f = false;

        } else {
            out("", r, null, c);

        }

    }

    debug.print("\n", .{});
}

pub fn pr(comptime f: anytype, s: anytype) void {
    stdout.print(f, s) catch {};
}

pub fn dpr(comptime f: anytype, s: anytype) void {
    if (!dbg) return;

    debug.print(f, s);
}

pub fn gen(comptime T: anytype) type {
    const N = Array(T);

    return struct {
//        var al: G.allocator();

        al: mem.Allocator,
        d: Array(N),
        l: *N,

        pub fn init(al: anytype) @This() {
            var s: @This() = undefined;

            s.al = al;
            s.d = Array(N).init(al);
          
            return s;
        }

        pub fn items(sl: anytype) []N {
            return sl.d.items;
        }

        pub fn h(sl: anytype) usize {
            return sl.d.items.len;
        }

        pub fn w(sl: anytype) usize {
            return sl.l.items.len;
        }

        pub fn new(sl: anytype) !void {
            const l = N.init(sl.al);

            try sl.d.append(l);

            const i = sl.d.items;

            sl.l = &i[i.len-1];
        }

        pub fn add(sl: anytype, v: anytype) !void {
            try sl.l.append(v);
        }

        pub fn get(sl: anytype, ii: anytype, cc: anytype) T {

            const i: usize = @intCast(ii);
            const c: usize = @intCast(cc);

            return sl.d.items[i].items[c];
        }

        pub fn get2(sl: anytype, p: anytype) T {

            return sl.get(p[0], p[1]);
        }

        pub fn set(
            sl: anytype, ii: anytype, jj: anytype,
            t: anytype
        ) !void {

            const i: usize = @intCast(ii);
            const j: usize = @intCast(jj);

            const c = sl.d.items;
        
            assert(i < c.len);

            const r = c[i].items;

            deb("r2", r.len);

            assert(j < r.len);

            const x = r[j];

            _ = switch(t) {
                T.set => assert(x == T.fre),
                T.fre => assert(x == T.set),
            };

            r[j] = t;
        }

        pub fn set2(sl: anytype, p: anytype, t: anytype) !void {

            const i = p[0];
            const j = p[1];

            while (i >= sl.d.items.len) {
                try sl.new();
            }            

            const c = sl.d;        

            var r = c.items[i];

            while (j >= r.items.len) {
                try r.append(T.fre);
            }

            r.items[j] = t;
            c.items[i] = r;
        }

        pub fn deinit(sl: anytype) void {
            for (sl.d.items) |i| {
                i.deinit();

            }
            sl.d.deinit();
        }
    };
}

pub fn genS(comptime T: anytype) type {
    const N = Array(T);

    return struct {
//        var al: G.allocator();

        al: mem.Allocator,
        d: StringMap(N),
        l: []const u8,

        pub fn init(al: anytype) !@This() {
            var sl: @This() = undefined;

            sl.al = al;
            sl.d = StringMap(N).init(al);

            return sl;
        }

        pub fn items(sl: anytype) []N {
            return sl.d.items;
        }

        pub fn h(sl: anytype) usize {
            return sl.d.items.len;
        }

        pub fn new(sl: anytype, x: anytype) !void {

            const al = sl.al;

            const l = N.init(al);
            try sl.d.put(x, l);

            sl.l = x;
        }

        pub fn add(sl: anytype, v: anytype) !void {

            var l = sl.d.get(sl.l) orelse return error.missing;

            try l.append(v);

            try sl.d.put(sl.l, l);
        }

        pub fn get(sl: anytype, x: anytype) !N {

            return sl.d.get(x) orelse return error.missing;
        }

        pub fn set(
            sl: anytype, ii: anytype, jj: anytype,
            t: anytype
        ) !void {

            const i: usize = @intCast(ii);
            const j: usize = @intCast(jj);

            const c = sl.d.items;
        
            assert(i < c.len);

            const r = c[i].items;

            deb("r2", r.len);

            assert(j < r.len);

            const x = r[j];

            _ = switch(t) {
                T.set => assert(x == T.fre),
                T.fre => assert(x == T.set),
            };

            r[j] = t;
        }

        pub fn set2(sl: anytype, p: anytype, t: anytype) !void {

            const i = p[0];
            const j = p[1];

            while (i >= sl.d.items.len) {
                try sl.new();
            }            

            const c = sl.d;        

            var r = c.items[i];

            while (j >= r.items.len) {
                try r.append(T.fre);
            }

            r.items[j] = t;
            c.items[i] = r;
        }

        pub fn deinit(sl: anytype) void {

            var j = sl.d.valueIterator();
            while (j.next()) |v| {
                v.deinit();
            }
            var d = sl.d;
            d.deinit();

            // ArrayHashMap
//            for (sl.d.items) |i| {
//                i.deinit();
//
//            }
//            sl.d.deinit();

        }
    };
}

pub fn genH(comptime T: anytype) type {
    const N = HashArray(T, void);

    return struct {
//        var al: G.allocator();

        al: mem.Allocator,
        d: Array(N),
        l: *N,

        pub fn init(al: anytype) @This() {
            var s: @This() = undefined;

            s.al = al;
            s.d = Array(N).init(al);
          
            return s;
        }

        pub fn items(sl: anytype) []N {
            return sl.d.items;
        }

        pub fn h(sl: anytype) usize {
            return sl.d.items.len;
        }

        pub fn w(sl: anytype) usize {
            return sl.l.items.len;
        }

        pub fn new(sl: anytype) !void {
            const l = N.init(sl.al);

            try sl.d.append(l);

            const i = sl.d.items;

            sl.l = &i[i.len-1];
        }

        pub fn add(sl: anytype, v: anytype) !void {
            try sl.l.put(v, {});
        }

        pub fn chc(sl: anytype, ii: anytype, cc: anytype) bool {

//            const i: usize = @intCast(ii);
//            const c: usize = @intCast(cc);

            assert(ii >= 0);

            if (ii >= sl.d.items.len) return false;

            const t = sl.d.items[ii];

            return t.contains(cc);
        }

        pub fn get2(sl: anytype, p: anytype) T {

            return sl.get(p[0], p[1]);
        }

        pub fn set(
            sl: anytype, ii: anytype, jj: anytype,
            t: anytype
        ) !void {

            const i: usize = @intCast(ii);
            const j: usize = @intCast(jj);

            const c = sl.d.items;
        
            assert(i < c.len);

            const r = c[i].items;

            deb("r2", r.len);

            assert(j < r.len);

            const x = r[j];

            _ = switch(t) {
                T.set => assert(x == T.fre),
                T.fre => assert(x == T.set),
            };

            r[j] = t;
        }

        pub fn set2(sl: anytype, p: anytype) !void {

            const i = p[0];
            const j = p[1];

            while (i >= sl.d.items.len) {
                try sl.new();
            }
            
            try sl.put(i, j);            
        }

        pub fn put(sl: anytype, i: anytype, j: anytype) !void {

            try sl.d.items[i].put(j, {});
        }

        pub fn deinit(sl: anytype) void {
            for (sl.d.items) |ii| {

                var i = ii;
                i.deinit();

            }
            sl.d.deinit();
        }
    };
}

pub fn num(v: anytype, t: anytype) !t {
    var n: t = undefined;

    if (v[0] >= '0' and v[0] <= '9') {
        n = fmt.parseUnsigned(t, v, 10) catch |e| {
            err("Invalid int", v) catch {};

            return e;
        };
    } else {
//        puts("num", v);
//        try err("num", v);

        return error.num;
    }

    return n;
}

pub fn spl(d: anytype, s: anytype) mem.SplitIterator(u8, .any) {
    return mem.splitAny(u8, d, s);
//    return mem.split(u8, d, s);
}

pub fn eql(d: anytype, s: anytype) bool {
    return mem.eql(u8, d, s);
}

pub fn rep(aa: anytype, l: anytype) !Array(@TypeOf(l)) {

    var a = aa;

    const e = a.items.len;

    try a.append(l);

    if (fin(a, l.l)) |i| {
        if (i != e) _ = a.swapRemove(i);
    }

    return a;
}

pub fn fin(a: anytype, l: anytype) ?usize {
    var z: ?usize = null;

    for (a.items, 0..) |v, i| {

        if (eql(v.l, l)) {
            z = i;
            break;
        }
    }

    return z;
}

pub fn rem(aa: anytype, l: anytype) !Array(@TypeOf(l)) {

    var a = aa;

    const z = fin(a, l);

    if (z) |i| {
        _ = a.orderedRemove(i);       
    }

    return a;
}

pub fn swp(n: anytype, l: anytype) void {
    const t = l.*;
          l.* = n.*;
          n.* = t;
}

pub fn sort(d: anytype) void {

    mem.sort(u64, d.*, {}, comptime std.sort.asc(u64));
}

pub fn sort2(d: anytype) void {

    mem.sort([2]u64, d.*, {}, comptime cmp0([2]u64));
}

pub fn setx(c: anytype, x: anytype, i: anytype, j: anytype) !bool {

    assert(i < j);

    const r = .{i, j};

    if (!c.chc(x, r)) {
        try c.set2(.{x, r});

        return true;
    }

    return false;
}

pub fn wal(l: anytype, z: anytype) !bool {

    for (l) |k| {
        const i = k[0];
        const j = k[1];

        if (i <= z and z <= j) {
            return true;
        }
    }

    return false;
}

pub fn sum(l: anytype) u64 {

    var r: u64 = 0;

    for (l) |v| {
        r += v;
    }

    return r;
}


// Copied & modified
// std/sort.zig
pub fn cmp0(comptime T: type) fn (void, T, T) bool {
    return struct {
        pub fn inner(_: void, a: T, b: T) bool {
            return a[0] < b[0];
        }
    }.inner;
}
