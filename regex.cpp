#include <vector>
#include <iterator>
#include <string>

#include "regex.h"

enum NodeType {
    NodeType_Verbatim,
    NodeType_Start,
    NodeType_End
};

struct Node {
    NodeType type;
    char c;

    // The alternative continuation from this node
    Node* branch;
}

typedef std::vector<Node> node_list;
typedef std::vector<int> node_ix_list;

static void make_branch(Node& branch_point, Node* new_branch) {
    // Traverse branch points until we find one that is empty
    Node& n(branch_point);
    if(n.branch == 0) {
        n.branch = new_branch;
    }
    else make_branch(*n.branch, new_branch);
}

static void connect_forward_branch_points(node_list& nodes, node_ix_list& forward_branch_points) {
    node_list::iterator node_it = nodes.begin();
    for(node_ptr_list::const_iterator it = forward_branch_points.begin(); it != forward_branch_points.end(); it++) {
        Node& n = nodes.at(*it); 
        
        if(std::distance(node_it, nodes.end()) >= 2) {
            make_branch(n, it + 2);
        } else {
            make_branch(n, &nodes.back);
        }
    }
}

node_list compile(const std::string& input) {
    size_t max_size = input.size() * 2;
    node_list nodes(max_size);
    node_ix_list forward_branch_points(max_size);

    nodes.push_back(StartNode());
    for(std::string::const_iterator it = input.begin(); it != input.end(); it++) {
        const char c = *it;
        if('*' == c) {
            forward_branch_points.push_back(std::distance(it, input.begin()));
        }
        nodes.push_back(VerbatimNode());
        nodes.back.c = c;
        if('+' == c || '*' == c) {
            make_branch(nodes.back.branch, &nodes.back.branch);
        }
        else {
            nodes.back.branch = 0;
        }
    }
    nodes.push_back(EndNode());

    connect_forward_branch_points(nodes, forward_branch_points);

    return nodes;
}
