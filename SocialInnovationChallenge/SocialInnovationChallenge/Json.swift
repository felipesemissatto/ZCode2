//
//  JsonCandidates.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 18/12/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//
import UIKit
import FirebaseFirestore

class Json {

    var candidates = """
                [
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Jardinagem"],
                        "dateOfBirth": "20111994",
                        "description": "Procuro uma oportunidade para me reinserir na sociedade através de um emprego digno. Quero me reaproximar da minha família e oferecer a ela o que não pude dar antes.",
                        "desires": ["Auxiliar minha família.","Completar o ensino médio.","Ter um carro próprio."],
                        "documentId": "vazio",
                        "experiences": ["Centro Penitenciário"],
                        "experiencesDescription": ["Jardinagem para prefeitura de Campinas"],
                        "name": "José Carlos",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa01.jpg?alt=media&token=f8b42b3f-7c29-4a88-a7ce-d4f19e46f25c",
                        "region": "Jundiaí - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Auxiliar de construção civil","Auxiliar de Cozinha"],
                        "dateOfBirth": "21111994",
                        "description": "Atualmente a minha esposa sustenta a casa, mas não é o suficiente para pagar as contas. Busco um emprego para dar uma  melhor condição de vida para minha família.",
                        "desires": ["Ter condições de cuidar da minha família","Dar uma boa condição de vida aos meus filhos.","Fazer faculdade."],
                        "documentId": "vazio",
                        "experiences": ["Construtora Aulus","Complexo Penitenciário"],
                        "experiencesDescription": ["Ajudante de pedreiro.","Auxiliar de cozinha."],
                        "name": "João Pereira",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa02.jpg?alt=media&token=0b318816-e147-41d9-b268-4b54b10a803d",
                        "region": "Campinas - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Corte e costura","Artesanato"],
                        "dateOfBirth": "22111994",
                        "description": "Saí recentemente da prisão e estou a procura de trabalho para refazer a minha vida de forma honesta.",
                        "desires": ["Fazer faculdade.","Conseguir um trabalho honesto."],
                        "documentId": "vazio",
                        "experiences": ["Ambev","Pano Social"],
                        "experiencesDescription": ["Auxiliar de limpeza, 2 meses","Costureira associada, 6 meses"],
                        "name": "Ana Aparecida de Souza",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa03.jpg?alt=media&token=ce84665e-5311-4657-b497-8cbe004ab312",
                        "region": "Belo Horizonte - MG",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Auxiliar de cozinha"],
                        "dateOfBirth": "23111994",
                        "description": "Sou casado, tenho dois filhos e, agora que estou livre, quero ser um exemplo para eles e dar a educação que eu não tive.",
                        "desires": ["Possibilitar um ensino de qualidade para o meu filho.","Casa própria."],
                        "documentId": "vazio",
                        "experiences": ["Polo Wear"],
                        "experiencesDescription": ["Estoquista e vendedora."],
                        "name": "Ricardo Rocha",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa04.jpg?alt=media&token=d3389bdf-b80b-4b9f-97f6-c6982a7537f5",
                        "region": "São Paulo - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Jardinagem"],
                        "dateOfBirth": "24111994",
                        "description": "Fiz escolhes ruins no passado e paguei pelos meus erros. Hoje eu luto para melhorar de vida.",
                        "desires": ["Ter vida descente."],
                        "documentId": "vazio",
                        "experiences": ["Floricultura","Restaurante Guaca"],
                        "experiencesDescription": ["Vendedor.","Auxiliar de limpeza."],
                        "name": "Pedro Oliveira",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa05.jpg?alt=media&token=2a743a71-735c-4028-9e57-9a54acb59e3e",
                        "region": "São José dos Campos - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Ensino médio completo","Ajudante de pedreiro"],
                        "dateOfBirth": "25111994",
                        "description": "Admito que errei, mas paguei pelos meus erros e  me esforço para mostrar isso a sociedade e conseguir uma segunda chance.",
                        "desires": ["Fazer faculdade.","Provar que eu mudei."],
                        "documentId": "vazio",
                        "experiences": ["Construtora","Pizzaria"],
                        "experiencesDescription": ["Auxiliar de pedreiro.","Ajudante de cozinha."],
                        "name": "João da Silva",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa06.jpg?alt=media&token=13618460-f891-430e-8f1e-39f1e48ef909",
                        "region": "Bauru - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Jardinagem"],
                        "dateOfBirth": "26111994",
                        "description": "Procuro uma oportunidade para me reinserir na sociedade através de um emprego digno. Quero me reaproximar da minha família e oferecer a ela o que não pude dar antes.",
                        "desires": ["Auxiliar minha família.","Completar o ensino médio.","Ter um carro próprio."],
                        "documentId": "vazio",
                        "experiences": ["Centro Penitenciário"],
                        "experiencesDescription": ["Jardinagem para prefeitura de Campinas"],
                        "name": "José Carlos",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa01.jpg?alt=media&token=f8b42b3f-7c29-4a88-a7ce-d4f19e46f25c",
                        "region": "Jundiaí - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Auxiliar de construção civil","Auxiliar de Cozinha"],
                        "dateOfBirth": "27111994",
                        "description": "Atualmente a minha esposa sustenta a casa, mas não é o suficiente para pagar as contas. Busco um emprego para dar uma  melhor condição de vida para minha família.",
                        "desires": ["Ter condições de cuidar da minha família","Dar uma boa condição de vida aos meus filhos.","Fazer faculdade."],
                        "documentId": "vazio",
                        "experiences": ["Construtora Aulus","Complexo Penitenciário"],
                        "experiencesDescription": ["Ajudante de pedreiro.","Auxiliar de cozinha."],
                        "name": "João Pereira",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa02.jpg?alt=media&token=0b318816-e147-41d9-b268-4b54b10a803d",
                        "region": "Campinas - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Corte e costura","Artesanato"],
                        "dateOfBirth": "28111994",
                        "description": "Saí recentemente da prisão e estou a procura de trabalho para refazer a minha vida de forma honesta.",
                        "desires": ["Fazer faculdade.","Conseguir um trabalho honesto."],
                        "documentId": "vazio",
                        "experiences": ["Ambev","Pano Social"],
                        "experiencesDescription": ["Auxiliar de limpeza, 2 meses","Costureira associada, 6 meses"],
                        "name": "Ana Aparecida de Souza",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa03.jpg?alt=media&token=ce84665e-5311-4657-b497-8cbe004ab312",
                        "region": "Belo Horizonte - MG",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Auxiliar de cozinha"],
                        "dateOfBirth": "29111994",
                        "description": "Sou casado, tenho dois filhos e, agora que estou livre, quero ser um exemplo para eles e dar a educação que eu não tive.",
                        "desires": ["Possibilitar um ensino de qualidade para o meu filho.","Casa própria."],
                        "documentId": "vazio",
                        "experiences": ["Polo Wear"],
                        "experiencesDescription": ["Estoquista e vendedora."],
                        "name": "Ricardo Rocha",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa04.jpg?alt=media&token=d3389bdf-b80b-4b9f-97f6-c6982a7537f5",
                        "region": "São Paulo - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Jardinagem"],
                        "dateOfBirth": "30111994",
                        "description": "Fiz escolhes ruins no passado e paguei pelos meus erros. Hoje eu luto para melhorar de vida.",
                        "desires": ["Ter vida descente."],
                        "documentId": "vazio",
                        "experiences": ["Floricultura","Restaurante Guaca"],
                        "experiencesDescription": ["Vendedor.","Auxiliar de limpeza."],
                        "name": "Pedro Oliveira",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa05.jpg?alt=media&token=2a743a71-735c-4028-9e57-9a54acb59e3e",
                        "region": "São José dos Campos - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Ensino médio completo","Ajudante de pedreiro"],
                        "dateOfBirth": "01121994",
                        "description": "Admito que errei, mas paguei pelos meus erros e  me esforço para mostrar isso a sociedade e conseguir uma segunda chance.",
                        "desires": ["Fazer faculdade.","Provar que eu mudei."],
                        "documentId": "vazio",
                        "experiences": ["Construtora","Pizzaria"],
                        "experiencesDescription": ["Auxiliar de pedreiro.","Ajudante de cozinha."],
                        "name": "João da Silva",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa06.jpg?alt=media&token=13618460-f891-430e-8f1e-39f1e48ef909",
                        "region": "Bauru - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Jardinagem"],
                        "dateOfBirth": "02121994",
                        "description": "Procuro uma oportunidade para me reinserir na sociedade através de um emprego digno. Quero me reaproximar da minha família e oferecer a ela o que não pude dar antes.",
                        "desires": ["Auxiliar minha família.","Completar o ensino médio.","Ter um carro próprio."],
                        "documentId": "vazio",
                        "experiences": ["Centro Penitenciário"],
                        "experiencesDescription": ["Jardinagem para prefeitura de Campinas"],
                        "name": "José Carlos",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa01.jpg?alt=media&token=f8b42b3f-7c29-4a88-a7ce-d4f19e46f25c",
                        "region": "Jundiaí - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Auxiliar de construção civil","Auxiliar de Cozinha"],
                        "dateOfBirth": "03121994",
                        "description": "Atualmente a minha esposa sustenta a casa, mas não é o suficiente para pagar as contas. Busco um emprego para dar uma  melhor condição de vida para minha família.",
                        "desires": ["Ter condições de cuidar da minha família","Dar uma boa condição de vida aos meus filhos.","Fazer faculdade."],
                        "documentId": "vazio",
                        "experiences": ["Construtora Aulus","Complexo Penitenciário"],
                        "experiencesDescription": ["Ajudante de pedreiro.","Auxiliar de cozinha."],
                        "name": "João Pereira",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa02.jpg?alt=media&token=0b318816-e147-41d9-b268-4b54b10a803d",
                        "region": "Campinas - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Corte e costura","Artesanato"],
                        "dateOfBirth": "04121994",
                        "description": "Saí recentemente da prisão e estou a procura de trabalho para refazer a minha vida de forma honesta.",
                        "desires": ["Fazer faculdade.","Conseguir um trabalho honesto."],
                        "documentId": "vazio",
                        "experiences": ["Ambev","Pano Social"],
                        "experiencesDescription": ["Auxiliar de limpeza, 2 meses","Costureira associada, 6 meses"],
                        "name": "Ana Aparecida de Souza",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa03.jpg?alt=media&token=ce84665e-5311-4657-b497-8cbe004ab312",
                        "region": "Belo Horizonte - MG",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Auxiliar de cozinha"],
                        "dateOfBirth": "05121994",
                        "description": "Sou casado, tenho dois filhos e, agora que estou livre, quero ser um exemplo para eles e dar a educação que eu não tive.",
                        "desires": ["Possibilitar um ensino de qualidade para o meu filho.","Casa própria."],
                        "documentId": "vazio",
                        "experiences": ["Polo Wear"],
                        "experiencesDescription": ["Estoquista e vendedora."],
                        "name": "Ricardo Rocha",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa04.jpg?alt=media&token=d3389bdf-b80b-4b9f-97f6-c6982a7537f5",
                        "region": "São Paulo - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Jardinagem"],
                        "dateOfBirth": "06121994",
                        "description": "Fiz escolhes ruins no passado e paguei pelos meus erros. Hoje eu luto para melhorar de vida.",
                        "desires": ["Ter vida descente."],
                        "documentId": "vazio",
                        "experiences": ["Floricultura","Restaurante Guaca"],
                        "experiencesDescription": ["Vendedor.","Auxiliar de limpeza."],
                        "name": "Pedro Oliveira",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa05.jpg?alt=media&token=2a743a71-735c-4028-9e57-9a54acb59e3e",
                        "region": "São José dos Campos - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Ensino médio completo","Ajudante de pedreiro"],
                        "dateOfBirth": "07121994",
                        "description": "Admito que errei, mas paguei pelos meus erros e  me esforço para mostrar isso a sociedade e conseguir uma segunda chance.",
                        "desires": ["Fazer faculdade.","Provar que eu mudei."],
                        "documentId": "vazio",
                        "experiences": ["Construtora","Pizzaria"],
                        "experiencesDescription": ["Auxiliar de pedreiro.","Ajudante de cozinha."],
                        "name": "João da Silva",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa06.jpg?alt=media&token=13618460-f891-430e-8f1e-39f1e48ef909",
                        "region": "Bauru - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Jardinagem"],
                        "dateOfBirth": "08121994",
                        "description": "Procuro uma oportunidade para me reinserir na sociedade através de um emprego digno. Quero me reaproximar da minha família e oferecer a ela o que não pude dar antes.",
                        "desires": ["Auxiliar minha família.","Completar o ensino médio.","Ter um carro próprio."],
                        "documentId": "vazio",
                        "experiences": ["Centro Penitenciário"],
                        "experiencesDescription": ["Jardinagem para prefeitura de Campinas"],
                        "name": "José Carlos",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa01.jpg?alt=media&token=f8b42b3f-7c29-4a88-a7ce-d4f19e46f25c",
                        "region": "Jundiaí - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Auxiliar de construção civil","Auxiliar de Cozinha"],
                        "dateOfBirth": "09121994",
                        "description": "Atualmente a minha esposa sustenta a casa, mas não é o suficiente para pagar as contas. Busco um emprego para dar uma  melhor condição de vida para minha família.",
                        "desires": ["Ter condições de cuidar da minha família","Dar uma boa condição de vida aos meus filhos.","Fazer faculdade."],
                        "documentId": "vazio",
                        "experiences": ["Construtora Aulus","Complexo Penitenciário"],
                        "experiencesDescription": ["Ajudante de pedreiro.","Auxiliar de cozinha."],
                        "name": "João Pereira",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa02.jpg?alt=media&token=0b318816-e147-41d9-b268-4b54b10a803d",
                        "region": "Campinas - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Corte e costura","Artesanato"],
                        "dateOfBirth": "10121994",
                        "description": "Saí recentemente da prisão e estou a procura de trabalho para refazer a minha vida de forma honesta.",
                        "desires": ["Fazer faculdade.","Conseguir um trabalho honesto."],
                        "documentId": "vazio",
                        "experiences": ["Ambev","Pano Social"],
                        "experiencesDescription": ["Auxiliar de limpeza, 2 meses","Costureira associada, 6 meses"],
                        "name": "Ana Aparecida de Souza",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa03.jpg?alt=media&token=ce84665e-5311-4657-b497-8cbe004ab312",
                        "region": "Belo Horizonte - MG",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Auxiliar de cozinha"],
                        "dateOfBirth": "11121994",
                        "description": "Sou casado, tenho dois filhos e, agora que estou livre, quero ser um exemplo para eles e dar a educação que eu não tive.",
                        "desires": ["Possibilitar um ensino de qualidade para o meu filho.","Casa própria."],
                        "documentId": "vazio",
                        "experiences": ["Polo Wear"],
                        "experiencesDescription": ["Estoquista e vendedora."],
                        "name": "Ricardo Rocha",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa04.jpg?alt=media&token=d3389bdf-b80b-4b9f-97f6-c6982a7537f5",
                        "region": "São Paulo - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Jardinagem"],
                        "dateOfBirth": "12121994",
                        "description": "Fiz escolhes ruins no passado e paguei pelos meus erros. Hoje eu luto para melhorar de vida.",
                        "desires": ["Ter vida descente."],
                        "documentId": "vazio",
                        "experiences": ["Floricultura","Restaurante Guaca"],
                        "experiencesDescription": ["Vendedor.","Auxiliar de limpeza."],
                        "name": "Pedro Oliveira",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa05.jpg?alt=media&token=2a743a71-735c-4028-9e57-9a54acb59e3e",
                        "region": "São José dos Campos - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    },
                    {
                        "contact": ["5519993085702", "z.code.bepid@gmail.com"],
                        "courses": ["Ensino médio completo","Ajudante de pedreiro"],
                        "dateOfBirth": "10121994",
                        "description": "Admito que errei, mas paguei pelos meus erros e  me esforço para mostrar isso a sociedade e conseguir uma segunda chance.",
                        "desires": ["Fazer faculdade.","Provar que eu mudei."],
                        "documentId": "vazio",
                        "experiences": ["Construtora","Pizzaria"],
                        "experiencesDescription": ["Auxiliar de pedreiro.","Ajudante de cozinha."],
                        "name": "João da Silva",
                        "photo": "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/pessoa06.jpg?alt=media&token=13618460-f891-430e-8f1e-39f1e48ef909",
                        "region": "Bauru - SP",
                        "video": "vazio",
                        "uid": "vazio"
                    }
                ]
"""

    func writeJsonFirebase() {
        
        do {
            let json = try JSONSerialization.jsonObject(with:candidates.data(using:.utf8)!, options: []) as! [[String: Any]]
            for i in 0...json.count - 1
            {
                Firestore.firestore().collection("candidates").document().setData(json[i])
            }
        } catch  {
            print(error)
        }
    }
}
