function getGraphData(notes, retentions) {

    console.log('getGraphData()');
    console.assert(notes != null && notes.length);
    console.assert(retentions != null);

    let settings = window.graphSettings;

    // let byTag = {};
    let tagCounts = {};
    let edges = [];
    let nodes = [];

    // let allNids = new Set();
    // let refs = {};


    let lblTrimRe = /^(was (ist|sind|waren) (der|die|das)?|wie laute[tn] (der|die|das)|wie kann man|what is)/gi;

    function lblCut(lbl) {
        lbl = lbl.replace(lblTrimRe, '...').trim();

        if (lbl && lbl.length > 35) {
            return lbl.substring(0, 32) + '...';
        }
        return lbl;
    }
    // regexp to look out for references to other nids
    // let nidReferenceRxp = new RegExp("(?:[^\\d]|^)(\\d{6,})(?:[^\\d]|$)", 'g');

    // count the occurences of each tag
    for (var i = 0; i < notes.length; i++) {
        // // let nid = notes[i][0];
        // allNids.add(nid);
        let tags = notes[i][1];

        // let flds = notes[i][2];
        // check fields for refs to other notes
        // for (let fld of flds) {
        //     let match;
        //     do {
        //         match = nidReferenceRxp.exec(fld);
        //         if (match && match.length) {
        //             if (!(nid in refs)) {
        //                 refs[nid] = [];
        //             }
        //             let reffedNid = Number(match[1]);
        //             if (!refs[nid].includes(reffedNid)) {
        //                 refs[nid].push(reffedNid);
        //             }
        //         }
        //     } while (match);
        // }
        for (let t of tags) {
            if (!(t in tagCounts)) {
                tagCounts[t] = 1;
            } else {
                tagCounts[t]++;
            }
        }
    }


    // group the notes by their tags
    for (var i = 0; i < notes.length; i++) {
        let [nid, tags, _, lbl] = notes[i];
        // if (tags.length) {
        //     for (let t of tags) {
        //         if (!(t in byTag)) {
        //             byTag[t] = [];
        //         }
        //         byTag[t].push(nid);
        //     }
        // }
        let ret  = retentions[Number(nid)] || null;
        nodes.push({
            data: { id: "n_" + nid, label: lblCut(lbl), ret: ret },
            group: "nodes",
        });
    }

    let idC = 0;
    let nodesWithEdges = new Set();


    let scores = [];

    let start = performance.now();


    let c = 0;
    let tcl = 0; 
    let dcl = 0;
    

    let nid = window.graphNID;
    let [nid0, tags0, flds0, _, dids0] = notes.find(n => n[0] === nid);


    for (let i1 = 0; i1 < notes.length; i1++) {
        if (notes[i1][0] === nid ) {
            continue;
        }
    
        let [nid1, tags1, flds1, _, dids1] = notes[i1];
        let score = 0;
        c++;

        //
        // collect points
        //

        // +5 points if creation date within 30 seconds 
        if (Math.abs(nid0 - nid1) / 1000 <= 30) {
            score += 5;
            tcl++;
        }  

        // +4 points if creation date within 1 minute 
        else if (Math.abs(nid0 - nid1) / 1000 <= 60) {
            score += 4;
            tcl++;
        }  

        // +3 points if creation date within 10 minutes
        else if (Math.abs(nid0 - nid1) / 1000 <= 600) {
            score += 3;
            tcl++;
        }

        // +1 point if creation date within 1 hour
        else if (Math.abs(nid0 - nid1) / 1000 <= 3600) {
            score += 1;
            tcl++;
        } 

        // +1 point if same deck
        if (dids0.length && dids1.length && dids0.find(did0 => dids1.find(did1 => did1 === did0) != null)) {
            score += 1;
            dcl++;
        }

        for (let t0 of tags0 || []) {
            if (settings.excludeTags && settings.excludeTags.includes(t0)) {
                continue;
            }
            if (tags1.length && tags1.includes(t0) && t0 in tagCounts && tagCounts[t0] <= settings.tagBoundary) {

                if (tagCounts[t0] >= 100) {
                    // +1 point for each tag in common that has 100-999 notes
                    score += 1;
                } else if (tagCounts[t0] >= 50){
                    // +2 points for each tag in common that has less than 100 notes
                    score += 2;
                } else if (tagCounts[t0] >= 10) {
                    // +3 points for each tag in common that has less than 50 notes
                    score += 3;
                }  else {
                    // +4 points for each tag in common that has less than 10 notes
                    score += 4;
                }
                // +1 point for each nested tag level
                score += 1 * (t0.split('::').length - 1);
            }
        }

        // // +0.5 points for each equal field
        // for (let f0 of flds0 || []) {
        //     for (let f1 of flds1 || []) {
        //         if (f0.length && f1.length && f0 === f1) {
        //             if (flds0.length < 5 && flds1.length < 5) {
        //                 score += 0.5;
        //             } else {
        //                 score += 0.3;
        //             }
        //         } 
        //     }
        // }

        if (score > 2) {
            scores.push([nid0, nid1, score]);
        }

    }

    console.log(`[Graph] Finished collecting scores, took ${Math.trunc(performance.now() - start)}ms`);
    console.log(`[Graph] Creation Date proximity found for ${Math.trunc(tcl * 100.0 / c)}% of pairs`);
    console.log(`[Graph] Same Deck found for ${Math.trunc(dcl * 100.0 / c)}% of pairs`);
    console.log(`[Graph] ${scores.length} note pairs have a score > 0`);
    let boundary = settings.scoringIncludeTopXPercent;
    if (boundary < 1 || boundary > 100) {
        alert("Invalid boundary for scoring: " + boundary);
    }

    if (scores.length) {
        scores.sort(function (s1, s2) {
            return s2[2] - s1[2];
        });
        console.log(`[Graph] Highest score is ${scores[0][2]}`);
        console.log(`[Graph] Lowest score > 0 is ${scores[scores.length-1][2]}`);
        
        let topX = scores.slice(0, Math.trunc(scores.length * boundary / 100) || 1);
        let minScore = topX[topX.length-1][2];
        let res = [];
        let c = 0;
        let maxEdgeCount = 100;
        for (let s of scores) {
            c++;
            if (c > maxEdgeCount) {
                break;
            }
            if (s[2] >= minScore) {
                res.push(s);
            }
        }
        console.log(`[Graph] Scoring, boundary is ${boundary}, took first ${res.length} edges out of ${scores.length}`);

        for (let [nid0, nid1, _] of res) {

            idC++;

            edges.push({
                group: "edges",
                data: {
                    id: "e_" + idC,
                    source: "n_"+ nid0,
                    target: "n_" + nid1,
                },
            });
            if (!nodesWithEdges.has('n_' + nid0)) {
                nodesWithEdges.add('n_' + nid0);
            }
            if (!nodesWithEdges.has('n_' + nid1)) {
                nodesWithEdges.add('n_' + nid1);
            }
        }
    }

    // // create edges between notes with explicit linkings
    // let explicitLinkingsCounter = 0;
    // for (let [nid, reffedNids] of Object.entries(refs)) {
    //     for (let reffedNid of reffedNids) {
    //         if (allNids.has(reffedNid) && nid !== reffedNid) {
    //             explicitLinkingsCounter++;
    //             idC++;
    //             edges.push({
    //                 group: "edges",
    //                 data: {
    //                     id: "e_" + idC,
    //                     source: 'n_' + nid,
    //                     target: "n_" + reffedNid,
    //                 },
    //             });
    //             if (!nodesWithEdges.has('n_' + nid)) {
    //                 nodesWithEdges.add('n_' + nid);
    //             }
    //             if (!nodesWithEdges.has('n_' + reffedNid)) {
    //                 nodesWithEdges.add('n_' + reffedNid);
    //             }
    //         }
    //     }
    // }
    // console.log(`[graph] Created ${explicitLinkingsCounter} explicit linking(s).`);
    nodes = nodes.filter(n => nodesWithEdges.has(n.data.id));

    return { edges: edges, nodes: nodes };

}
function retColor(ret) {
    if (ret === null) {
        return "#999";
    }
    if (ret > 0.8) {
        return "hsl(96, 81%, 33%)";
    }
    if (ret > 0.7) {
        return "#9EDE73";
    }
    if (ret > 0.6) {
        return "#F7EA00";
    }
    if (ret > 0.5) {
        return "#E48900";
    }
    return "#BE0000";
}

function renderGraph() {
    console.log("renderGraph()");
    if (typeof(cytoscape) === 'undefined') {
        console.log('to renderGraph()');
        setTimeout(renderGraph, 40);
        return;
    }

    setTimeout(function () {
        let container = document.getElementById("cytoscape-container");
        container.innerHTML = "";

        let pBuildNodes = performance.now();
        let { nodes, edges } = getGraphData(
            notes,
            retentions,
        );

        console.log(
            "Built " + nodes.length + " nodes, " + edges.length + " edges."
        );
        console.log(
            "Build nodes: " + (performance.now() - pBuildNodes) + " ms"
        );
        // setStatus('Running tests...');
        // setStatus('Starting graphing...');
        let pGraphStart = performance.now();

        /**
         * CytoScape.js
         */

        var cy = cytoscape({
            container: container,
            elements: {
                nodes: nodes,
                edges: edges,
            },

            style: [
                {
                    selector: "node",
                    style: {
                        // 'background-color': '#666',
                        height: (n) => 7,
                        width: (n) => 7,
                        "background-color": (n) => { return n.data("ret") ? retColor(Number(n.data("ret"))) : window.graphSettings.defaultNodeColor; },
                        'label': 'data(label)',
                        'font-size': 7,
                        'color': 'white'
                    },
                },

                {
                    selector: "edge",
                    style: {
                        width: "2px",

                        "line-color": window.graphSettings.edgeColor,
                    },
                },
            ],

            layout: {
                name: "fcose",
                quality: "default",
                randomize: true,
                animate: false,
                animationDuration: 1000,
                animationEasing: undefined,
                fit: true,
                padding: 30,
                nodeDimensionsIncludeLabels: false,
                uniformNodeDimensions: true,
                packComponents: false,
                step: "all",

                samplingType: true,
                sampleSize: 25,
                nodeSeparation: 175,
                piTol: 0.0000001,
                nodeRepulsion: (node) => 8500,
                idealEdgeLength: (edge) => 150,
                edgeElasticity: (edge) => 0.85,
                nestingFactor: 0.1,
                numIter: 2500,
                tile: true,
                tilingPaddingVertical: 10,
                tilingPaddingHorizontal: 10,
                gravity: 0.05,
                gravityRangeCompound: 10.5,
                gravityCompound: 15.0,
                gravityRange: 50.8,
                initialEnergyOnIncremental: 0.3,
                fixedNodeConstraint: undefined,
                alignmentConstraint: undefined,
                relativePlacementConstraint: undefined,
                textureOnViewport: true,

                /* layout event callbacks */
                ready: () => {}, // on layoutready
                stop: () => {}, // on layoutstop
            },
        });

        // cy.elements().unbind("mouseover");
        // cy.elements().bind("mouseover", (event) => renderTooltip(event));

        // cy.elements().unbind("mouseout");
        // cy.elements().bind("mouseout", (event) => hideTooltip(event));
        // window.addEventListener("resize", onResize);
        window.cy = cy;
        cy.userPanningEnabled( true )
        console.log('end renderGraph()');
    }, 30);

}

renderGraph();