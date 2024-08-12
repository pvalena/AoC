// Const
pub const std = @import("std");

pub const fmt = std.fmt;
pub const io = std.io;
pub const mem = std.mem;
pub const debug = std.debug;
pub const assert = debug.assert;
pub const stdout = io.getStdOut().writer();
pub const tst = std.time.timestamp;
pub const child = std.ChildProcess;


// Types
pub const Array = std.ArrayList;
pub const Hash = std.AutoHashMap;
pub const HashArray = std.AutoArrayHashMap;
pub const StringHash = std.StringHashMap;
pub const StringHashArray = std.StringArrayHashMap;


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

    dpr(s ++ ": {any}\n", .{d});
}

pub fn puts(comptime ll: anytype, d: []const u8) void {
    if (!dbg) return;

    const l = if (ll.len > 0) ll ++ ": " else ll;

    dpr(l ++ "{s}\n", .{d});
}

pub fn putc(comptime ll: anytype, d: anytype) void {
    if (!dbg) return;
    
    const l = if (ll.len > 0) ll ++ ": " else ll;

    dpr(l ++ "{c}\n", .{d});
}

pub fn putd(comptime ll: anytype, d: anytype) void {
    if (!dbg) return;

    const l = if (ll.len > 0) ll ++ ": " else ll;

    dpr(l ++ "{d}\n", .{d});
}

pub fn err(comptime l: anytype, d: anytype) !void {
    dbg = true;

    const s = "\nError[" ++ l ++ "]";

    prl();
    deb(s, d);

    prl();

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

        np.* = try num(u64, n);
    }

    prs("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

    return d;
}

// Int to char //
pub fn toc(
    j: anytype

) u8 {

    const q: u8 = @intCast(j);
    return 'A' + q;
}

// Higlight for position in line //
pub fn lin(comptime l: anytype, i: anytype) void {

    if (!dbg) return;

    if (l.len < 3) {
        const k = 3 - l.len;

        for (0..k) |_| dpr(" ", .{});
    }
    dpr(l ++ ": ", .{});

    for (0..i) |_| {
        dpr(" ", .{});
    }

    dpr("^ {}\n", .{i});
}

// Print 1D array - using display function; with optional slice 
pub fn out(comptime l: anytype, f: anytype, s: ?[]u64, c: anytype) void {
    if (!dbg) return;

    if (l.len < 3) {
        const k = 3 - l.len;

        for (0..k) |_| dpr(" ", .{});
    }
    dpr(l ++ ": ", .{});

    for (f.items) |t| {

        const v = c(t);

        dpr("{c}", .{v});
    }

    if (s) |ss| {
        dpr(" <- ", .{});

        for (ss) |v| {
            dpr("{} ", .{v});
        }
    }
    prl();
}

// Print 2D Array using `out`
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

    prl();
}

pub fn eut(comptime l: anytype, f: anytype, s: ?[]u64,
    c: anytype
) !void {
    dbg = true;

    out(l, f, s, c);
    try err("", null);
}

pub fn eut2(comptime l: anytype, f: anytype, s: ?[]u64,
    c: anytype
) !void {
    dbg = true;

    out2(l, f, s, c);
    try err("", null);
}

pub fn dpr(comptime f: anytype, s: anytype) void {
    if (!dbg) return;

    debug.print(f, s);
}

pub fn prs(comptime f: anytype) void {
    if (!dbg) return;

    debug.print(f ++ "\n", .{});
}

pub fn prl() void {
    dpr("\n", .{});
}

pub fn pr(comptime f: anytype, s: anytype) void {
    stdout.print(f, s) catch {};
}


// Generic Array => Array => T, 2d //
pub fn gen(comptime T: anytype) type {
    const N = Array(T);

    return struct {
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


// Generic StringHash => Array => T, 2d //
pub fn genS(comptime T: anytype) type {
    const N = Array(T);

    const S = []const u8;

    return struct {
//        var al: G.allocator();

        al: mem.Allocator,
        d: StringHash(N),
        l: S,

        pub fn init(al: anytype) !@This() {
            var sl: @This() = undefined;

            sl.al = al;
            sl.d = StringHash(N).init(al);

            return sl;
        }

        pub fn new(sl: anytype, x: anytype) !void {

            const al = sl.al;

            const l = N.init(al);

            var d = sl.d;

            try d.put(x, l);

            sl.d = d;
            sl.l = x;
        }

        pub fn add(sl: anytype, v: anytype) !void {

            var l = sl.d.get(sl.l) orelse return error.missing;

            try l.append(v);

            try sl.d.put(sl.l, l);
        }

        pub fn put(sl: anytype, x: anytype, v: anytype) !void {

            var l = sl.d.get(x) orelse return error.missing;

            try l.append(v);

            try sl.d.put(x, l);
        }

        pub fn get(sl: anytype, x: anytype) !N {

            return sl.d.get(x) orelse return error.missing;
        }

        pub fn deinit(sl: anytype) void {

            var j = sl.d.valueIterator();
            while (j.next()) |v| {
                v.deinit();
            }
            var d = sl.d;
            d.deinit();
        }
    };
}

// Generic StringHash => StringHash => T, 2d //
pub fn gen2S(comptime T: anytype) type {

    const S = []const u8;

    const N = StringHash(T);
    const M = StringHash(N);

    const KV = struct {
        S,
        N
    };

    return struct {
        al: mem.Allocator,
        d: M,
        l: S,
        m: u64,

        k: M.Iterator,

        pub fn init(al: anytype) !@This() {
            var sl: @This() = undefined;

            sl.al = al;
            sl.d = M.init(al);
            sl.m = 0;

            return sl;
        }

        pub fn clone(c: anytype) !@This() {
            var sl: @This() = undefined;

            sl.al = c.al;

//            sl.d = try c.d.clone();
            sl.d = M.init(c.al);

            var j = c.d.keyIterator();

            while (j.next()) |k| {

                const q = try c.get(k.*);

                const n = try q.clone();

                try sl.d.put(k.*, n);
            }



            sl.m = c.m;

            return sl;
        }

        pub fn new(sl: anytype, x: anytype) void {

            sl.l = x;
        }

        pub fn add(sl: anytype, x: anytype, v: anytype) !void {

            try sl.put(sl.l, x, v);
        }

        pub fn remove(sl: anytype, x: anytype, v: anytype) !N {

            var l = try sl.get(x);
            _ = l.remove(v);

            try sl.d.put(x, l);

            return l;
        }

        pub fn count(sl: anytype) usize {

            return sl.d.count();
        }

        pub fn put(sl: anytype, x: anytype, y: anytype, v: anytype) !void {

            const d = sl.d;

            var l = switch(d.contains(x)) {
                true =>
                    d.get(x) orelse return error.missing,

                false =>
                    N.init(sl.al),
            };

            try l.put(y, v);

            const c = l.count();

            if (sl.m < c) sl.m = c; 

            try sl.d.put(x, l);
        }

        pub fn get(sl: anytype, x: S) !N {

            return sl.d.get(x) orelse return error.missing;
        }

        pub fn get2(sl: anytype, x: anytype, y: anytype) !N {

            try wip();

            _ = y;

            return sl.d.get(x) orelse return error.missing;
        }

        pub fn iterator(c: anytype) void {

            c.k = c.d.iterator();
        }

        pub fn next(c: anytype) ?KV {

            var kv: ?KV = null;
                        
            if (c.k.next()) |e| {

//                const x = try c.get(l);

                kv = .{e.key_ptr.*, e.value_ptr.*};
            }

            return kv;
        } 

        pub fn deinit(sl: anytype) void {

            var j = sl.d.valueIterator();
            while (j.next()) |v| {
                v.deinit();
            }
            var d = sl.d;
            d.deinit();

        }
    };
}


// Generic Queue //
pub fn que(B: anytype) type {

    const A = genQ(B, void);

    const D = struct {
        pub fn d(c: B, _: void) void {
            c.deinit();
        }
    }.d;

    return struct {

        q: A,

        pub fn init(a: anytype) !@This() {

            var c: @This() = undefined;

            c.q = try A.init(a, D);

            return c;
        }

        pub fn deinit(c: anytype) void {

            c.q.deinit();
        }

        pub fn put(c: anytype, v: anytype) !void {

            try c.q.put(v);
        }

        pub fn count(c: anytype) usize {

            return c.q.count();
        }

        pub fn next(c: anytype) ?B {

            prs("next: ");

            const g = c.q.next();

            deb("g", g);

            if (g) |v| {
                const w, _ = v;

                return w;
            }

            return null;
        }
    };
}


// Generic coords-based Hash => T, 1d //
pub fn genK(H: anytype, D: anytype, K: anytype, T: anytype) type {

    const Q = [D]K;

    const A = H(Q, T);

    const KV = struct {
        Q,
        T 
    };

    return struct {
        a: A,
        b: [2]Q,

        l: mem.Allocator,

        k: A.Iterator,

        pub fn init(l: anytype) !@This() {

            var c: @This() = undefined;

            c.a = A.init(l);

            for (0..D) |i| c.b[0][i] = 0;

            c.b[1] = c.b[0];

            c.l = l;

            return c;
        }

        pub fn clone(o: anytype) !@This() {

            var c: @This() = undefined;

            c.a = try o.a.clone();

            c.b = o.b;
            c.l = o.l;

            return c;
        }

        pub fn count(c: anytype) usize {

            return c.a.count();
        }

        pub fn clear(c: anytype) void {

            c.a.clearRetainingCapacity();
        }

        pub fn add(c: anytype, k: Q, v: T) !void {

            c.bor(k);

            try c.a.put(k, v);
        }

        pub fn put(c: anytype, k: Q) !void {

            c.bor(k);

            try c.a.put(k, {});
        }

        pub fn bor(c: anytype, k: anytype) void {

            for (0 .. D) |i| {

                if (k[i] > c.b[i][1]) {
                    c.b[i][1] = k[i];
                }

                if (k[i] < c.b[i][0]) {
                    c.b[i][0] = k[i];
                }
            }
        }

        pub fn prd(c: anytype, dis: anytype) void {

            if (!dbg) return;

            prl();

            var i = c.b[0][0];

            while (i <= c.b[0][1]) : (i += 1) {

                dpr("   ", .{});

                var j = c.b[1][0];

                while (j <= c.b[1][1]) : (j += 1) {

                    const k = .{i, j};

                    const v = try c.getn(k);

//                    if (v) |d|
//                        deb("k", .{k, d});

                    dpr("{c}", .{dis(v)});
                }

                prl();
            }

            prl();
        }
  
        pub fn prk(c: anytype) void {

            if (!dbg) return;

//            dpr("\n" ++ l ++ "[k]: ", .{});

            var k = c.a.keyIterator();

            while (k.next()) |v| {
                dpr("[{}, {}] ", .{v[0], v[1]});
            }

            prl();
        }

        pub fn remove(c: anytype, k: anytype) !void {

            if (c.a.swapRemove(k)) return;

            try err("C.remove", k);
        }

        pub fn pop(c: anytype) ?KV {

            const e = c.a.popOrNull();

            if (e) |k|
                return .{k.key, k.value};

            return null;
        }

        pub fn get(c: anytype, k: Q) !T {

            return c.a.get(k) orelse return error.dataMissing;
        }

        pub fn getn(c: anytype, k: Q) !?T {

            return c.a.get(k);
        }

        pub fn contains(c: anytype, k: anytype) bool {

            return c.a.contains(k);
        }

        pub fn iterator(c: anytype) void {

            c.k = c.a.iterator();
        }

        pub fn next(c: anytype) ?KV {

            var kv: ?KV = null;
                        
            if (c.k.next()) |e| {

                kv = .{e.key_ptr.*, e.value_ptr.*};
            }

            return kv;
        } 

        pub fn deinit(c: anytype) void {

            var a = c.a;

            a.deinit();
        }
    };
}

// Generic Hash-Queue => T, 1d //
pub fn genQ(comptime Q: anytype, comptime T: anytype) type {

    const A = HashArray(Q, T);

    const KV = struct {
        Q,
        T 
    };

    return struct {
        a: A,
        b: A,

        s: u64,

        d: ?*const fn(Q, T)void,

        l: mem.Allocator,

        pub fn init(l: anytype, d: anytype) !@This() {

            var c: @This() = undefined;

            c.a = A.init(l);
            c.b = A.init(l);

            c.d = d;
            c.l = l;

            c.s = 0;

            return c;
        }

        pub fn clone(o: anytype) !@This() {

            var c: @This() = undefined;

            c.a = try o.a.clone();
            c.b = try o.b.clone();

            c.l = o.l;
            c.d = o.d;
            c.s = o.s;

            return c;
        }

        pub fn count(c: anytype) usize {

            return c.a.count() + c.b.count();
        }

        pub fn clear(c: anytype) void {

            c.a.clearRetainingCapacity();
            c.b.clearRetainingCapacity();
        }

        pub fn add(c: anytype, k: Q, v: T) !void {

            try c.b.put(k, v);
        }

        pub fn put(c: anytype, k: Q) !void {

            try c.b.put(k, {});
        }

        pub fn remove(c: anytype, k: anytype) !void {

            if (c.a.swapRemove(k)) return;
            if (c.b.swapRemove(k)) return;

            try err("C.remove", k);
        }

        pub fn get(c: anytype, k: Q) !T {

            return c.a.get(k) orelse {
                return c.b.get(k) orelse return error.dataMissing;
            };
        }

        pub fn getn(c: anytype, k: Q) !?T {

            return c.a.get(k) orelse c.b.get(k);
        }

        pub fn contains(c: anytype, k: anytype) bool {

            return (c.a.contains(k) or c.b.contains(k));
        }

        pub fn next(c: anytype) ?KV {

            if (c.a.count() > 0) return c.pop(&c.a);

            if (c.b.count() <= 0) return null;

            swp(&c.a, &c.b);

            c.s += 1;

            return c.next();
        }

        pub fn steps(c: anytype) u64 {

            return c.s;
        }

        pub fn deinit(c: anytype) void {

            if (c.d) |d| {

                while (c.next()) |w| {

                    const k, const v = w;

                    d(k, v);
                }
            }

            c.a.deinit();
            c.b.deinit();
        }

        ///

        fn pop(_: anytype, a: anytype) ?KV {

            const e = a.popOrNull();

            if (e) |k| return .{k.key, k.value};

            return null;
        }
    };
}

// Generic Hash => Hash => void, 2d // 
pub fn genH(comptime T: anytype) type {

    const N = HashArray(T, void);

    const A = HashArray(T, N);

    return struct {
//        var al: G.allocator();

        a: mem.Allocator,
        d: A,
        l: *N,

        pub fn init(a: anytype) @This() {
            var s: @This() = undefined;

            s.a = a;
            s.d = A.init(a);
          
            return s;
        }

        pub fn clone(o: anytype) !@This() {
            var s: @This() = undefined;

            s.a = o.a;

            s.d = A.init(o.a);

            var k = o.d.iterator();

            while (k.next()) |e| {

                const i = e.key_ptr.*;
                const j = e.value_ptr.*;

                const n = try j.clone();

                try s.d.put(i, n);
            }
          
            return s;
        }

        pub fn items(sl: anytype) []N {
            return sl.d.values();
        }

        pub fn keys(sl: anytype) []T {
            return sl.d.keys();
        }

        pub fn count(s: anytype) usize {
            return s.d.count();
        }

        pub fn w(sl: anytype) usize {
            return sl.l.keys().len;
        }

        pub fn new(s: anytype, i: anytype) !void {

            if (s.d.contains(i)) return;

            var l = N.init(s.a);

            try s.d.put(i, l);

            s.l = &l;
        }

        pub fn add(s: anytype, i: anytype) !void {
            try s.l.put(i, {});
        }

        pub fn get(sl: anytype, p: anytype) !N {

            return sl.d.get(p) orelse return error.dataMissing;
        }

        pub fn remove(s: anytype, x: anytype, v: anytype) !void {

            var l = try s.get(x);

            _ = l.swapRemove(v);

            try s.d.put(x, l);
        }

        pub fn clear(sl: anytype) T {

            for (sl.d.items) |ii| {

//                var i = ii;
                ii.clearRetainingCapacity();

            }
        }

        pub fn get2(sl: anytype, p: anytype) T {

            return sl.get(p[0], p[1]);
        }

        pub fn set2(sl: anytype, p: anytype) !void {

            const i = p[0];
            const j = p[1];

            try sl.put(i, j);            
        }

        pub fn put(s: anytype, i: anytype, j: anytype) !void {

            try s.new(i);

            var l = try s.get(i);

            try l.put(j, {});

            try s.d.put(i, l);
        }

        pub fn chc(s: anytype, p: anytype) !bool {

            const i, const j = p;

            const l = try s.get(i);

//            try err("chc", p);

            return l.contains(j);
        }

        pub fn deinit(sl: anytype) void {
            for (sl.items()) |ii| {

                var i = ii;
                i.deinit();

            }
            sl.d.deinit();
        }
    };
}

// Get ordered pair //
pub fn pir(comptime T: anytype, i: anytype, j: anytype) [2]T {

    return if (i < j) .{i, j} else .{j, i};
}

// Parse uint //
pub fn num(t: anytype, v: anytype) !t {
    var n: t = undefined;

    n = fmt.parseUnsigned(t, v, 10) catch |e| {

        puts("num", v);

        err("Invalid int", v) catch {};

        return e;
    };

    return n;
}

// Parse int //
pub fn nus(t: anytype, v: anytype) !t {

    const n = fmt.parseInt(t, v, 10) catch |e| {

        puts("nus", v);

        err("Invalid int", v) catch {};

        return e;
    };

    return n;
}

// Split int array into slices //
pub fn spl(d: anytype, s: anytype) mem.SplitIterator(u8, .any) {
    return mem.splitAny(u8, d, s);
}

// Compare 2d arrays //
pub fn eql(d: anytype, s: anytype) bool {
    return mem.eql(u8, d, s);
}

// Compare 2d coords //
pub fn eq2(d: anytype, s: anytype) bool {
    return d[0] == s[0] and d[1] == s[1];
}

// Find index in array, use `eql` function //
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

// 
pub fn rem(aa: anytype, l: anytype) !Array(@TypeOf(l)) {

    var a = aa;

    const z = fin(a, l);

    if (z) |i| {
        _ = a.swapRemove(i);       
    }

    return a;
}

// Swap two //
pub fn swp(n: anytype, l: anytype) void {
    const t = l.*;
          l.* = n.*;
          n.* = t;
}

// Sort array //
pub fn sort(d: anytype) void {

    mem.sort(u64, d.*, {}, comptime std.sort.asc(u64));
}

// Sort array of 2d coords //
pub fn sort2(d: anytype) void {

    mem.sort([2]u64, d.*, {}, comptime cmp0([2]u64));
}

// Check if inside interval pairs, 1d //
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

// Sum over slice, uint //
pub fn sum(l: anytype) u64 {

    var r: u64 = 0;

    for (l) |v| {
        r += v;
    }

    return r;
}

// Print coordinates, stored in Hash keys, 2d //
pub fn prk(comptime l: anytype, a: anytype) void {

    if (!dbg) return;

    dpr("\n" ++ l ++ "[k]: ", .{});

    var k = a.keyIterator();

    while (k.next()) |v| {
//        dpr("[{}, {}] ", .{v[0], v[1]});
        dpr("[{}, {}] ", v);
    }

    prl();
}

// Print 2D array, using display function //
pub fn pra(a: anytype, dis: anytype) void {

    if (!dbg) return;

    prl();

    for (a.items(), 0..) |rr, i| {

        _ = i;

        const r = rr.items;
    
        if (r.len <= 0) continue;
    
        dpr("   ", .{});

        for (r, 0..) |l, j| {

            _ = j;

//            dpr("{any}", l);
            dpr("{c}", .{dis(l)});
        }

        prl();
    }

    prl();
}


// Line collision detection, 1l x 1l, 3d //
pub fn col(
    x: anytype,
    y: anytype,
    g: anytype

) !bool {

    const n = x.k;
    const d = x.d;

    const o = y.k;

    var t = false;

    for (0..3) |i| {

        if (n[i] != o[i]) continue;

        var j, var k = try oth(i);

        for (0..2) |_| {

            if (d == j and n[d] <= o[d] and o[d] <= x.v) {

                const e = y.d;

                if (e == k and o[e] <= n[e] and n[e] <= y.v) return true;

                if (e == d and o[k] == n[k]) return true;
            }

            swp(&j, &k);
        }

        t = true;
    }

    if (!t) return false;

    var z = n;

    if (n[d] < x.v+1) {} else try err("x", x);

    for (n[d] .. x.v+1) |a| {

        z[d] = a;

        if (try cll(y, z, g)) return true;
    }

    return false;
}

// Line collision detection, 1p x 1l, 3d //
pub fn cll(
    y: anytype,
    n: anytype,
    w: anytype

) !bool {
    const o = y.k;
    const g = y.d;

    const e, const f = try oth(g);

    const r = (n[e] == o[e] and n[f] == o[f] and o[g] <= n[g] and n[g] <= y.v);

    _ = w;
    
    return r;
}

// Get maximum of the 2 values //
pub fn max(
    i: anytype,
    j: anytype,

) @TypeOf(i) {

    return if (i >= j) i else j;
}

// Get other 1d coords to the supplied one, uint //
pub fn oth(
    i: anytype,

) ![2]u64 {
    return switch(i) {
        0 => .{1, 2},
        1 => .{0, 2},
        2 => .{0, 1},

        else => return error.oth
    };
}

// Duplicate static array, copy contents manually // 
pub fn dup(
    i: anytype,

) @TypeOf(i) {

    const T = @TypeOf(i);

    var n: T = undefined;

    for (i, 0..) |v, j| {
        n[j] = v;
    }

    return n;
}

// One move = iteration on 2d field, 2dir, uint //
fn itr(
    i: anytype,
    x: anytype,
    k: anytype,
    n: anytype,
    c: anytype,

) bool {

    if (i == 0 and n[x] <= 0)
        return true;

    if (i == 2 and n[x] >= c.b[x])
        return true;

    n[x] = k[x] + i - 1;

    return false;
}

// Copy keys by iterating to array //
fn cop(
    q: anytype,
    e: anytype,

) void {
    
    var y = e.keyIterator();

    var i: usize = 0;

    while (y.next()) |z| {
        defer i += 1;

//    for (e, 0..) |z, i| {

        q[i] = z.*;
    }
}


// Copied & modified
// std/sort.zig - order by first value in array only //
pub fn cmp0(comptime T: type) fn (void, T, T) bool {
    return struct {
        pub fn inner(_: void, a: T, b: T) bool {
            return a[0] < b[0];
        }
    }.inner;
}
