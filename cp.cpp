#include <bits/stdc++.h>
using namespace std;
#define all(c) begin(c), end(c)
#define ssize(c) (int)c.size()

using ll = long long;
using ld = long double;
using vi = vector<int>;
using vll = vector<ll>;

#define EPS 1e-9
#define PI acosl(-1.0)
ld deg_to_rad(ld d) { return d * PI / 180.0; }
ld rad_to_deg(ld r) { return r * 180.0 / PI; }

template <class T>
int sgn(T x) { return (x > 0) - (x < 0); }
template <class T>
struct Point
{
    typedef Point P;
    T x, y;
    Point(T x = 0, T y = 0) : x(x), y(y) {}
    bool operator<(P p) const { return tie(x, y) < tie(p.x, p.y); }
    bool operator==(P p) const { return tie(x, y) == tie(p.x, p.y); }
    P operator+(P p) const { return P(x + p.x, y + p.y); }
    P operator-(P p) const { return P(x - p.x, y - p.y); }
    P operator-() const { return P(-x, -y); }
    P operator*(T d) const { return P(x * d, y * d); }
    P operator/(T d) const { return P(x / d, y / d); }
    T dot(P p) const { return x * p.x + y * p.y; }
    T cross(P p) const { return x * p.y - y * p.x; }
    T cross(P a, P b) const { return (a - *this).cross(b - *this); }
    T dist2() const { return x * x + y * y; }
    ld dist(P from = {0, 0}) const { return sqrtl((ld)(*this - from).dist2()); }
    // angle to x-axis in interval [-pi, pi]
    ld angle() const { return atan2(y, x); }
    // angle with custom center o in interval [0, pi]
    ld aob_angle(P o, P b)
    {
        return acosl((*this - o).dot(b - o) / sqrtl((*this - o).dist2() * (b - o).dist2()));
    }
    P unit() const { return *this / dist(); } // makes dist()=1
    P perp() const { return P(-y, x); }       // rotates +90 degrees
    P normal() const { return perp().unit(); }
    // returns point p rotated ccw of theta degrees wrt center c
    bool collinear(P q, P r) { return abs(this->cross(q, r)) < EPS; }
    bool ccw_check(P p, P q)
    { // returns true if the point is on the left side of line pq
        return (q - p).cross((*this) - p) > 0;
    }
    bool on_segment(P A, P B)
    { // returns true if this is on segment AB
        if (this->collinear(A, B) && this->x <= max(A.x, B.x) && this->x >= min(A.x, B.x) && this->y <= max(A.y, B.y) && this->y >= min(A.y, B.y))
            return true;
        else
            return false;
    }
    Point<ld> to_ld()
    {
        Point<ld> ldp((ld)(this->x), (ld)(this->y));
        return ldp;
    }
    friend ostream &operator<<(ostream &os, P p)
    {
        return os << "(" << p.x << ", " << p.y << ")";
    }
};
// clockwise rotation: use -theta, center = c
Point<ld> ccw_rotation(ld theta, const Point<ld> p, const Point<ld> c = Point<ld>(0, 0))
{
    ld rad = deg_to_rad(theta);
    return Point(
        cosl(rad) * (p.x - c.x) - sinl(rad) * (p.y - c.y) + c.x,
        sinl(rad) * (p.x - c.x) + cosl(rad) * (p.y - c.y) + c.y);
}
struct Line
{
    ld a, b, c; // b = 1 non-vertical lines, b = 0 vertical lines
    Line(ld a_, ld b_, ld c_) : a(a_), b(b_), c(c_) {}
    Line(const Point<ld> &p1, const Point<ld> &p2)
    {
        if (abs(p1.x - p2.x) < EPS)
        {
            a = 1.0;
            b = 0.0;
            c = -p1.x;
        }
        else
        {
            a = -(ld)(p1.y - p2.y) / (p1.x - p2.x);
            b = 1.0;
            c = -(ld)(a * p1.x) - p1.y;
        }
    }
    Line(Point<ld> &p, ld m)
    {
        a = m;
        b = 1.0;
        c = -((a * p.x) + (b * p.y));
    }
    bool check_parallel(Line l)
    {
        return (abs(a - l.a) < EPS) && (abs(b - l.b) < EPS);
    }
    bool check_same(Line l)
    {
        return this->check_parallel(l) && (abs(c - l.c) < EPS);
    }
    bool check_orthogonal(Line l)
    {
        return abs(a + 1 / l.a) < EPS;
    }
    bool check_intersection(Line l, Point<ld> &p)
    { // if true, P is the intersection point
        if (this->check_parallel(l))
            return false;
        p.x = (l.b * c - b * l.c) / (l.a * b - a * l.b);
        if (abs(b) > EPS)
            p.y = -(a * p.x + c);
        else
            p.y = -(l.a * p.x + c);
        return true;
    }
    Line operator+(Point<ld> p)
    { // translate line by vector
        return Line(a, b, c - p.y * b - a * p.x);
    }
    friend ostream &operator<<(ostream &os, Line l)
    {
        return os << "(" << l.a << ", " << l.b << ", " << l.c << ")";
    }
};
ld dist_to_line(Point<ld> p, Line l)
{
    return abs(l.a * p.x + l.b * p.y + l.c) / sqrtl(l.a * l.a + l.b * l.b);
}
Point<ld> closest_point(Point<ld> p, Line ln)
{ // returns the closest point to p on l
    ln = ln + (-p);
    ld t = ln.c / (ln.a * ln.a + ln.b * ln.b);
    return p + Point(-ln.a * t, -ln.b * t);
}
// returns intersection point between line AB and segment pq
Point<ld> intersec_line_seg(Point<ld> p, Point<ld> q, Point<ld> A, Point<ld> B)
{
    ld a = B.y - A.y, b = A.x - B.x, c = B.x * A.y - A.x * B.y;
    ld u = abs(a * p.x + b * p.y + c);
    ld v = abs(a * q.x + b * q.y + c);
    return Point<ld>((p.x * v + q.x * u) / (u + v), (p.y * v + q.y * u) / (u + v));
}
// use this for line equations where b is not always equal to 0 or 1
Line norm(ld a, ld b, ld c)
{
    if (abs(b) < EPS)
        b = 0.0;
    else
    {
        a /= b;
        c /= b;
        b = 1.0;
    }
    return Line(a, b, c);
}
ld perimeter(vector<Point<ll>> &poli)
{
    ld res = 0.0;
    int n = ssize(poli);
    for (int i = 1; i <= n; ++i)
        res += poli[i - 1].dist(poli[i % n]);
    return res;
}
// returns 2*area; area < 0 if clock-wise, area > 0 if ccw
ll double_area(vector<Point<ll>> &poli)
{
    ll res = 0;
    int n = ssize(poli);
    for (int i = 0; i < n; ++i)
        res += (poli[i % n].x * poli[(i + 1) % n].y - poli[(i + 1) % n].x * poli[i % n].y);
    return res;
}
ld double_area(vector<Point<ld>> &poli)
{
    ld res = 0;
    int n = ssize(poli);
    for (int i = 0; i < n; ++i)
        res += (poli[i % n].x * poli[(i + 1) % n].y - poli[(i + 1) % n].x * poli[i % n].y);
    return res;
}
bool check_convex(vector<Point<ll>> &poli)
{
    int n = ssize(poli);
    if (n < 3)
        return true;
    bool ft = poli[2].ccw_check(poli[0], poli[1]);
    for (int i = 1; i < n - 1; ++i)
        if ((poli[(i + 2) % n]).ccw_check(poli[i % n], poli[(i + 1) % n]) != ft)
        {
            return false; // concave
        }
    return true; // convex
}
// returns 1/0/-1 if pt inside/on vertex or edge/outside poli
int point_inside_polygon(Point<ll> pt, vector<Point<ll>> &poli)
{
    int n = ssize(poli);
    if (n == 1)
        return (pt == poli[0]) ? 0 : -1;
    if (n == 2)
        return pt.on_segment(poli[0], poli[1]) ? 0 : -1;
    bool on_polygon = false;
    ld sum = 0.0;
    for (int i = 0; i < n; i++)
    {
        if (pt == poli[i] || pt == poli[(i + 1) % n] || pt.on_segment(poli[i], poli[(i + 1) % n]))
        {
            return 0;
        }
        if (poli[(i + 1) % n].ccw_check(pt, poli[i]))
            sum += poli[i].aob_angle(pt, poli[(i + 1) % n]);
        else
            sum -= poli[i].aob_angle(pt, poli[(i + 1) % n]);
    }
    return abs(sum) > M_PI ? 1 : -1;
}
ld dist_point_segment(Point<ld> p, Point<ld> a, Point<ld> b)
{
    Line l(a, b);
    Point<ld> c = closest_point(p, l);
    Point<ld> pld = p.to_ld();
    if (c.x >= min(a.x, b.x) && c.x <= max(a.x, b.x) && c.y >= min(a.y, b.y) && c.y <= max(a.y, b.y))
    {
        return pld.dist(c);
    }
    ld dap = pld.dist(a.to_ld()), dbp = pld.dist(b.to_ld());
    if (dap - dbp < EPS)
        return dap;
    else
        return dbp;
}
// distance from pt to the closest side of the polygon
ld dist_point_poly(Point<ld> pt, vector<Point<ld>> &poli)
{
    ld best_dist = numeric_limits<ld>::max();
    int n = ssize(poli);
    for (int i = 0; i <= n; i++)
    {
        best_dist = min(best_dist, dist_point_segment(pt, poli[i % n], poli[(i + 1) % n]));
    }
    return best_dist;
}
// Returns the left subspace wrt AB
// for the one on the right, call cut_poly with A, B and all vertices in Q
// with the x negated and then negate the x of the result
vector<Point<ld>> cut_poly(Point<ld> A, Point<ld> B, const vector<Point<ld>> &Q)
{
    vector<Point<ld>> P;
    int n = ssize(Q);
    for (int i = 0; i < n; i++)
    {
        ld left1 = (B - A).cross(Q[i] - A), left2 = 0;
        left2 = (B - A).cross(Q[(i + 1) % n] - A);
        if (left1 > -EPS)
            P.push_back(Q[i % n]);
        if (left1 * left2 < -EPS)
            P.push_back(intersec_line_seg(Q[i], Q[(i + 1) % n], A, B));
    }
    return P;
}

int main()
{
    cin.tie(0)->sync_with_stdio(false);
    ll T;
    cin >> T;
    for (ll t = 0; t < T; t++)
    {
        ll n;
        cin >> n;
        vector<Point<ll>> room(n);
        for (int corner = 0; corner < n; corner++)
        {
            ll x, y;
            cin >> x >> y;
            room[corner] = Point(x, y);
        }

        Point<ld> camera = (room[0].to_ld() + room[1].to_ld()) * 0.5;

        Point<ld> a = room[0].to_ld();
        Point<ld> b = room[1].to_ld();
        Line cameraline = Line(a, b);

        Point<ld> c = ccw_rotation(-45, a, camera);
        Point<ld> d = ccw_rotation(45, b, camera);

        vector<Point<ld>> ldroom(n);
        for (int i = 0; i < n; i++)
            ldroom[i] = room[i].to_ld();
        ldroom = cut_poly(camera, d, ldroom);

        c = Point(-c.x, c.y);
        camera = Point(-camera.x, camera.y);
        for (int i = 0; i < n; i++)
            ldroom[i] = Point(-ldroom[i].x, ldroom[i].y);
        ldroom = cut_poly(camera, c, ldroom);
        for (int i = 0; i < n; i++)
            ldroom[i] = Point(-ldroom[i].x, ldroom[i].y);

        cout << double_area(ldroom) / double_area(room) << endl;
    }
}
