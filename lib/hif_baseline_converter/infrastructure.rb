module HifBaselineConverter
  class Infrastructure < Loader

    def initialize(file:)
      super
    end

    def convert
      infra_start_row = 30
      data_start = 31
      data_end = 72
      sheet_ary = @xlsx.to_a[data_start..data_end]
      infra_nums = sheet_ary[0].compact
      column_start = 5 # column e

      raise '"No. of HIF funded Infrastructure" must be defined' unless infra_nums.size > 1
      infra_num = infra_nums.last

      infrastructures = []

      infra_num.times do |num|
        col_num = column_start + num
        concerned_columns = @xlsx.column(col_num).to_a[data_start..data_end]
        descriptions = @xlsx.column('b').to_a[data_start..data_end]
        infrastructures << build_infratype(concerned_columns, descriptions)
      end
      infrastructures
    end

    def build_infratype(concerned_columns, descriptions = nil)
      concerned_columns.each_with_index do |a,i|
        p "#{a}, #{i}, #{descriptions[i] if descriptions}"
      end
      # buld the hash structure and map with the positions in the array
      {
        type:         concerned_columns[3],
        description:  concerned_columns[4],
        housingSitesBenefitting:  concerned_columns[5], # TODO: not in data structure
        outlinePlanningStatus:  {
          granted:                concerned_columns[6],
          grantedReference:       concerned_columns[7],
          targetSubmission:       date_parse(concerned_columns[8]),
          targetGranted:          date_parse(concerned_columns[9]),
          summaryOfCriticalPath:  concerned_columns[10],
        },
        fullPlanningStatus: {
          granted:                concerned_columns[11],
          grantedReference:       concerned_columns[12],
          targetSubmission:       date_parse(concerned_columns[13]),
          targetGranted:          date_parse(concerned_columns[14]),
          summaryOfCriticalPath:  concerned_columns[15],
        },
        s106: {
          requirement:            concerned_columns[15],
          summaryOfRequirement:   concerned_columns[17]
        },
        statutoryConsents: {
          anyConsents:        concerned_columns[18],
          detailsOfConsent:   concerned_columns[19],
          targetDateToBeMet:  date_parse(concerned_columns[20])
        },
        landOwnership: {
          underControlOfLA:           concerned_columns[21],
          ownershipOfLandOtherThanLA: concerned_columns[22],
          landAcquisitionRequired:    concerned_columns[23],
          howManySitesToAcquire:      concerned_columns[24],
          toBeAcquiredBy:             concerned_columns[25],
          targetDateToAcquire:        concerned_columns[26],
          summaryOfCriticalPath:      concerned_columns[27],
          procurement: {
            contractorProcured:     concerned_columns[28],
            nameOfContractor:       concerned_columns[29],
            targetDateToAquire:     date_parse(concerned_columns[30]),
            summaryOfCriticalPath:  concerned_columns[31]
          }
        },
        milestones: [{
          descriptionOfMilestone: concerned_columns[32],
          target: date_parse(concerned_columns[33]),
          summaryOfCriticalPath: concerned_columns[34]
        }],
        expectedInfrastructureStart: {
          targetDateOfAchievingStart: date_parse(concerned_columns[35]),
        },
        expectedInfrastructureCompletion: {
          targetDateOfAchievingCompletion: date_parse(concerned_columns[36]),
        },
        risksToAchievingTimescales: [{
            descriptionOfRisk:  concerned_columns[37],
            impactOfRisk:       concerned_columns[38],
            likelihoodOfRisk:   concerned_columns[39],
            mitigationOfRisk:   concerned_columns[40]
          }]
        }
    end

    def date_parse(field)
     field ? Date.parse(field) : nil
    end
  end
end


# __END__
#     "infrastructures": [
#       {
#         "type": "A House",
#         "description": "A house of cats",
#         "outlinePlanningStatus": {
#           "granted": true,
#           "grantedReference": "The Dogs",
#           "targetSubmission": "2020-01-01",
#           "targetGranted": "2020-01-01",
#           "summaryOfCriticalPath": "Summary of critical path"
#         },
#         "fullPlanningStatus": {
#           "granted": false,
#           "grantedReference": "1234",
#           "targetSubmission": "2020-01-01",
#           "targetGranted": "2020-01-01",
#           "summaryOfCriticalPath": "Summary of critical path"
#         },
#         "s106": {
#           "requirement": true,
#           "summaryOfRequirement": "Required"
#         },
#         "statutoryConsents": {
#           "anyConsents": true,
#           "detailsOfConsent": "Details of consent",
#           "targetDateToBeMet": "2020-01-01"
#         },
#         "landOwnership": {
#           "underControlOfLA": true,
#           "ownershipOfLandOtherThanLA": "Dave",
#           "landAcquisitionRequired": true,
#           "howManySitesToAcquire": 10,
#           "toBeAcquiredBy": "Dave",
#           "targetDateToAcquire": "2020-01-01",
#           "summaryOfCriticalPath": "Summary of critical path",
#           "procurement": {
#             "contractorProcured": true,
#             "nameOfContractor": "Dave",
#             "targetDateToAquire": "2020-01-01",
#             "summaryOfCriticalPath": "Summary of critical path"
#           }
#         },
#         "milestones": [
#           {
#             "descriptionOfMilestone": "Milestone One",
#             "target": "2020-01-01",
#             "summaryOfCriticalPath": "Summary of critical path"
#           }
#         ],
#         "expectedInfrastructureStart": {
#           "targetDateOfAchievingStart": "2020-01-01"
#         },
#         "expectedInfrastructureCompletion": {
#           "targetDateOfAchievingCompletion": "2020-01-01"
#         },
#         "risksToAchievingTimescales": [
#           {
#             "descriptionOfRisk": "Risk one",
#             "impactOfRisk": "High",
#             "likelihoodOfRisk": "High",
#             "mitigationOfRisk": "Do not do the thing"
#           }
#         ]
#       }
#     ]
