//
//  GridView.swift
//  CleanHarborsiOSCT
//
//  Created by Puja Gogineni on 2/15/24.
//

import SwiftUI

struct Grid {
    var rows: [[String]]
}

class GridViewModel: ObservableObject {
    @Published var grid: Grid = Grid(rows: [[]])
    @Published var gridSizeString: String = "" {
        didSet {
            guard !gridSizeString.isEmpty,
                    let size = Int(gridSizeString) else {
                gridSize = 0
                if !gridSizeString.isEmpty { gridSizeString = "" }
                return
            }
            
            gridSize = size
            
            // Adds empty row with 0s to avoid crash due to index out of range
            grid.rows.removeAll()
            for _ in 0..<gridSize {
                grid.rows.append(Array(repeating: "0", count: gridSize))
            }
        }
    }
    @Published var gridSize: Int = 0
    @Published var pathSuccessful: String = ""
    @Published var pathCost: String = ""
    @Published var path: String = ""

    func calculateMinimumCostPath() {
        var pathSuccessful: Bool = false
        var pathCost: Int = 0
        var path: [String] = []
        
        for row in 0..<gridSize {
            guard pathCost < 50 else { break }
            for column in 0..<gridSize - 1 {
                guard pathCost < 50 else { break }
                if row == 0 && column == 0 {
                    pathCost += Int(grid.rows[row][column]) ?? 0
                    path.append(grid.rows[row][column])
                } else {
                    
                    let neighbor1 = grid.rows[row - 1 >= 0 ? row - 1 : gridSize - 1][column + 1]
                    let neightbor2 = grid.rows[row][column + 1]
                    let neighbor3 = grid.rows[row + 1 < gridSize ? row + 1 : 0][column + 1]
                    
                    let minimumCostNeighbor = min(Int(neighbor1) ?? 0, Int(neightbor2) ?? 0, Int(neighbor3) ?? 0)
                    pathCost += minimumCostNeighbor
                    path.append(String(minimumCostNeighbor))
                }
                if (row == gridSize - 1 || row + 1 == gridSize - 1) && (column + 1 == gridSize - 1) {
                    pathSuccessful = true
                    break
                }
            }
        }
        
        self.pathSuccessful = pathSuccessful ? "True" : "False"
        self.pathCost = String(pathCost)
        self.path = path.joined(separator: ", ")
    }
}

struct GridView: View {
    @StateObject var viewModel: GridViewModel
    
    var body: some View {
        VStack {
            Text("Enter Grid Size: Must be between 1 - 10")
            TextField("", text: $viewModel.gridSizeString)
                .frame(width: 50, alignment: .center)
                .border(.black)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .onChange(of: viewModel.gridSizeString) { newValue in
                    // Make sure all characters entered here are Numbers
                    let filteredValue = newValue.filter { $0.isNumber }
                    if viewModel.gridSizeString != filteredValue {
                        viewModel.gridSizeString = filteredValue
                    }
                }
            if viewModel.gridSize > 10 {
                Text("Please enter value less than or equal to 10")
                    .foregroundColor(.red)
            } else if viewModel.gridSize > 0 {
                Spacer(minLength: 50)
                ForEach(0..<viewModel.gridSize, id: \.self) { row in
                    HStack {
                        ForEach(0..<viewModel.gridSize, id: \.self) { column in
                            TextField("0", text: $viewModel.grid.rows[row][column])
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .border(.black)
                                .onChange(of: viewModel.grid.rows[row][column]) { newValue in
                                    // Make sure all characters entered here are Numbers
                                    let filteredValue = newValue.filter { $0.isNumber }
                                    if viewModel.grid.rows[row][column] != filteredValue {
                                        viewModel.grid.rows[row][column] = filteredValue
                                    }
                                }
                        }
                    }
                    .padding([.leading, .trailing])
                }
                Spacer(minLength: 20)
                Button("Calculate") {
                    viewModel.calculateMinimumCostPath()
                }
                Spacer(minLength: 20)
                Text("Path Successful: \(viewModel.pathSuccessful)")
                Text("Cost of shortest path: \(viewModel.pathCost)")
                Text("Path: \(viewModel.path)")
            }
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(viewModel: GridViewModel())
    }
}

