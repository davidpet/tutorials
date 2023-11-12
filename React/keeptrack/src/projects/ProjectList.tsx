import { Project } from './Project';
import ProjectCard from './ProjectCard';
import ProjectForm from './ProjectForm';
import { useState } from 'react';

interface ProjectListProps {
  projects: Project[];
}

function ProjectList({ projects }: ProjectListProps) {
    const [projectBeingEdited, setProjectBeingEdited] = useState({});
    const handleEdit = (project: Project) => { setProjectBeingEdited(project);};

    return (
        <div className="row">
            {projects.map((project) => (
                <div key={project.id} className="cols-sm">
                              {project === projectBeingEdited ? (
                    <ProjectForm />
                    ) : (
                    <ProjectCard project={project} onEdit={handleEdit} />
                                 )}
                </div>
            ))}
        </div>
   );
}

export default ProjectList;
